extension MastodonAPI.Entities {
    /// Represents a category in the Mastodon fediverse.
    public struct Category: Codable, Hashable {
        // Name of the category
        public var category: String
        // Count of servers 
        public var servers_count: Int
    }
}
