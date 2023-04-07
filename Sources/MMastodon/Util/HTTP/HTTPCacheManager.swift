import Foundation

public protocol HTTPCacheManager : Actor {
    nonisolated func isCacheable(urlRequest: URLRequest) -> Bool
    func fetch(urlRequest: inout URLRequest) -> (Data, MastodonAPI.HTTPResponse)?
    func update(urlRequest: URLRequest, contents: Data, response: MastodonAPI.HTTPResponse)
}
