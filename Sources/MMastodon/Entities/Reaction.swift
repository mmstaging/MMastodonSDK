extension MastodonAPI.Entities {
    /// Represents an emoji reaction to an Announcement.
    public struct Reaction: Codable, Hashable {
        /// The emoji used for the reaction. Either a unicode emoji, or a custom emoji’s shortcode.
        public var name: String
        /// The total number of users who have added this reaction.
        public var count: Int
        /// If there is a currently authorized user: Have you added this reaction?
        public var me: String?
        /// If the reaction is a custom emoji: A link to the custom emoji.
        public var url: String?
        /// If the reaction is a custom emoji: A link to a non-animated version of the custom emoji.
        public var static_url: String?
    }
}
