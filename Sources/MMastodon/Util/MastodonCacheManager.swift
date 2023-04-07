import Foundation

/// Simple cache, no eviction polices, should handle Mastodon data loads for near term.
public actor MastodonCacheManager : HTTPCacheManager {
    public typealias HTTPResponse = MastodonAPI.HTTPResponse
    typealias CacheID = String

    var cacheFolderURL: URL
    /// Maps URL to Cache ID
    var manifest = [String: CacheID]()
    var cache = [CacheID: (Data, HTTPResponse)]()

    private func canonical(url: URL?) -> String? {
        guard let url else { return nil }
        return ([url.host() ?? "host"] + url.pathComponents.dropFirst()).joined(separator: "-")
    }

    public init() {
        // load manifest from disk
        cacheFolderURL = URL(string:"file:///")!

        do {
            let cacheRootURL = try FileManager.default.url(for:.documentDirectory, in:.userDomainMask, appropriateFor: nil, create: false)
            cacheFolderURL = cacheRootURL.appendingPathComponent("MastodonCache")
            if !FileManager.default.fileExists(atPath: cacheFolderURL.relativePath) {
                try FileManager.default.createDirectory(at: cacheFolderURL, withIntermediateDirectories: false, attributes: nil)
            }

            let manifestURL = cacheFolderURL.appendingPathComponent("manifest").appendingPathExtension("json")
            if let data = try? Data(contentsOf: manifestURL) {
                manifest = try JSONDecoder().decode([String:String].self, from: data)
            }

            var notFound = Set<CacheID>()

            for cacheID in manifest.values {
                let dataURL = cacheFolderURL.appendingPathComponent(cacheID).appendingPathExtension("data")
                guard let contents = try? Data(contentsOf: dataURL)
                else {
                    notFound.insert(cacheID)
                    continue
                }
                let respURL = cacheFolderURL.appendingPathComponent(cacheID).appendingPathExtension(".resp")
                var response: HTTPResponse
                if let data = try? Data(contentsOf: respURL) {
                    response = try JSONDecoder().decode(HTTPResponse.self, from: data)
                } else {
                    notFound.insert(cacheID)
                    continue
                }
                cache[cacheID] = (contents, response)
            }

            manifest = manifest.filter { !notFound.contains($0.value) }

            //TODO: Scan through folder to discover/cull any cache data files that are not mentioned in the manifest.

        } catch {
            print("Error initializing cache manager", error)
            manifest = [:]
        }
    }

    public nonisolated func isCacheable(urlRequest: URLRequest) -> Bool {
        guard urlRequest.httpMethod == "GET" else { return false }
        guard urlRequest.allHTTPHeaderFields?["Authorization"] == nil else { return false }
        guard let url = urlRequest.url, url.query == nil else { return false }

        if let cacheControl = urlRequest.value(forHTTPHeaderField: "Cache-Control"),
            cacheControl.lowercased().contains("no-cache") {
            return false
        }

        return true
    }

    public func fetch(urlRequest: inout URLRequest) -> (Data, HTTPResponse)? {
        guard
            let url = canonical(url: urlRequest.url),
            let cacheID = manifest[url],
            let (contents, httpResponse) = cache[cacheID]
        else { return nil }

        var headers = urlRequest.allHTTPHeaderFields!
        if let etag = urlRequest.value(forHTTPHeaderField: "Etag") {
            headers["If-None-Match"] = etag
        }
        if let lastModified = urlRequest.value(forHTTPHeaderField: "Last-Modified") {
            headers["If-Modified-Since"] = lastModified
        }
        urlRequest.allHTTPHeaderFields = headers

        return (contents, httpResponse)
    }

    public func update(urlRequest: URLRequest, contents: Data, response: HTTPResponse) {
        guard let url = canonical(url: urlRequest.url) else { return }
        guard
            200..<300 ~= response.statusCode
        else {
            purge(urlRequest: urlRequest)
            return
        }

        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .withoutEscapingSlashes

        let cacheID = manifest[url] ?? "CACHE-\(UUID().uuidString)"

        if manifest[url] == nil { // add to cache
            manifest[url] = cacheID
            if !saveManifest() {
                purge(urlRequest: urlRequest)
            }
        }

        cache[cacheID] = (contents, response)
        do {
            let cacheFileBaseURL = cacheFolderURL.appendingPathComponent(cacheID)
            try contents.write(to: cacheFileBaseURL.appendingPathExtension("data"), options: [.atomic])
            let responseJsonData = try jsonEncoder.encode(response)
            try responseJsonData.write(to: cacheFileBaseURL.appendingPathExtension("data"), options: [.atomic])
        } catch {
            //TODO: need proper handling
            fatalError("Cache.update caught error: \(error)")
        }
    }

    private func purge(urlRequest: URLRequest) {
        guard
            let url = canonical(url: urlRequest.url),
            let cacheID = manifest[url]
        else { return }

        manifest[url] = nil

        if saveManifest() {
            cache[cacheID] = nil
            let cacheFileBaseURL = cacheFolderURL.appendingPathComponent(cacheID)

            do {
                try FileManager.default.removeItem(at: cacheFileBaseURL.appendingPathExtension("data"))
                try FileManager.default.removeItem(at: cacheFileBaseURL.appendingPathExtension("resp"))
            } catch {
                //TODO: need proper handling
                print("Problem purging \(cacheID)", error)
            }
        }
    }

    private func saveManifest() -> Bool {
        do {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .withoutEscapingSlashes

            let manifestJsonData = try jsonEncoder.encode(manifest)
            let manifestURL = cacheFolderURL.appendingPathComponent("manifest").appendingPathExtension("json")
            try manifestJsonData.write(to: manifestURL, options: [.atomic])
            return true
        } catch {
            //TODO: need proper handling
            print("Couldn't save manifest", error)
        }
        return false
    }
}
