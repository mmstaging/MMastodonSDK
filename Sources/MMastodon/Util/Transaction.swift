import Foundation
import Logging

private actor SimpleCounter {
    private var counter = 1
    func nextTick() -> Int {
        counter += 1
        return counter
    }
}

private let simpleCounter = SimpleCounter()

extension MastodonAPI {
    public enum TransactionError: Error {
        case notSuccessful(HTTPResponse)
    }

    public class Transaction<T:Codable> {
        unowned let urlSession: URLSession
        unowned let cacheManager: HTTPCacheManager
        var urlRequest: URLRequest
        let logger: Logger

        public init(urlSession: URLSession, urlRequest: URLRequest, cacheManager: HTTPCacheManager) {
            self.urlSession = urlSession
            self.urlRequest = urlRequest
            logger = Logger(label: "mmpub.MMastodon.\(UUID().uuidString)")
            self.cacheManager = cacheManager
        }

        public func getEntity() async throws -> (T, HTTPResponse)  {
            var isRevalidating = false
            var cachedResponse: (Data,HTTPResponse)? = nil

            if cacheManager.isCacheable(urlRequest: urlRequest),
               let response = await cacheManager.fetch(urlRequest: &urlRequest) {
                isRevalidating = true
                cachedResponse = response
            }

            let counter = await simpleCounter.nextTick()
            logger.info("[HTTP REQUEST] #\(counter) \(urlRequest.cURLString)")
            var (data, response) = try await urlSession.data(for: urlRequest)
            let httpURLResponse = response as! HTTPURLResponse
            var httpResponse = HTTPResponse(from: httpURLResponse)
            logger.info("[HTTP RESPONSE] #\(counter) \(httpResponse.statusCode)")

            if isRevalidating {
                if httpResponse.statusCode == 304 {
                    (data, httpResponse) = cachedResponse!
                } else {
                    await cacheManager.update(urlRequest: urlRequest, contents: data, response: httpResponse)
                }
            }

            guard httpResponse.statusCode == 200 else { throw TransactionError.notSuccessful(httpResponse) }
            let dto = try JSONDecoder().decode(T.self, from: data)
            return (dto, httpResponse)
        }

        public func getEntityAndLinks() async throws -> (T, PaginationLinks, HTTPResponse)  {
            let (entity, response) = try await getEntity()
            return (entity, PaginationLinks(headers: response.allHeaderFields), response)
        }
    }
}
