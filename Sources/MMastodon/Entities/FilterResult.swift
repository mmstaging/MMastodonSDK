extension MastodonAPI.Entities {
    /// Represents a filter whose keywords matched a given status.
    public struct FilterResult: Codable, Hashable {
        /// The filter that was matched.
        public var filter: Filter
        /// The keyword within the filter that was matched.
        public var keyword_matches: [String]?
        /// The status ID within the filter that was matched.
        public var status_matches: String?
    }
}
