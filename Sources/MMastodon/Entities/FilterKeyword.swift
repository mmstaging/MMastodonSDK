extension MastodonAPI.Entities {
    /// Represents a keyword that, if matched, should cause the filter action to be taken.
    public struct FilterKeyword: Codable, Hashable {
        /// The ID of the FilterKeyword in the database.
        public var id: String
        /// The phrase to be matched against.
        public var keyword: String
        /// Should the filter consider word boundaries? See implementation guidelines for filters.
        public var whole_word: Bool
        /// Instruct filter update to delete this key
        public var _destroy: Bool?
    }
}
