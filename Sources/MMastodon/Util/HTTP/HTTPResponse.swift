import Foundation

extension MastodonAPI {
    /// A remake of HTTPURLResponse, but conforming to Codable
    public struct HTTPResponse: Codable {
        public let statusCode: Int
        public var allHeaderFields: [String: String]?

        public init(from resp: HTTPURLResponse) {
            statusCode = resp.statusCode
            allHeaderFields = resp.allHeaderFields as? [String: String] ?? [:]
        }
    }
}
