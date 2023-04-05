extension MastodonAPI.Entities {
    /// Represents a hashtag that is featured on a profile.
    public struct FeaturedTag: Codable, Hashable {
        /// The internal ID of the featured tag in the database.
        public var id: String
        /// The name of the hashtag being featured.
        public var name: String
        /// A link to all statuses by a user that contain this hashtag.
        public var url: String
        /// The number of authored statuses containing this hashtag.
        public var statuses_count: Int
        /// The timestamp of the last authored status containing this hashtag.
        public var last_status_at: String
    }
}
