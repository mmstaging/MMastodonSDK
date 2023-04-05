extension MastodonAPI.Entities {
    /// Represents a custom emoji.
    public struct CustomEmoji: Codable, Hashable {
        /// The name of the custom emoji.
        public var shortcode: String
        /// A link to the custom emoji.
        public var url: String
        /// A link to a static copy of the custom emoji.
        public var static_url: String
        /// Whether this Emoji should be visible in the picker or unlisted.
        public var visible_in_picker: Bool
        /// Used for sorting custom emoji in the picker.
        public var category: String?
    }
}
