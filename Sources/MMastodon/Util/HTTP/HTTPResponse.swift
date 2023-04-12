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

        public func value(forHTTPHeaderField field: String) -> String? {
            let field = field.lowercased()
            for (key, value) in allHeaderFields ?? [:] where key.lowercased() == field {
                return value
            }
            return nil
        }
    }
}
