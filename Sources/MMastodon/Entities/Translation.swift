extension MastodonAPI.Entities {
    /// Represents the result of machine translating some status content
    public struct Translation: Codable, Hashable {
        /// The translated text of the status.
        public var content: String
        /// The language of the source text, as auto-detected by the machine translation provider.
        public var detected_source_language: String
        /// The service that provided the machine translation.
        public var provider: String
    }
}
