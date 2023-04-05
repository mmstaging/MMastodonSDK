extension MastodonAPI.Entities {
    /// Represents a Mastodon server.
    public struct Server: Codable, Hashable {
        public let domain: String
        public let version: String
        public let description: String
        public let languages: [String]
        public let region: String
        public let categories: [String]
        public let proxied_thumbnail: String?
        public let total_users: Int
        public let last_week_users: Int
        public let approval_required: Bool
        public let language: String
        public let category: String
    }
}
