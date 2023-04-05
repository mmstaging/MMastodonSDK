extension MastodonAPI.Entities {
    /// Represents a status's source as plain text.
    public struct StatusSource: Codable, Hashable {
        /// ID of the status in the database.
        public var id: String
        /// The plain text used to compose the status.
        public var text: String
        /// The plain text used to compose the status’s subject or content warning.
        public var spoiler_text: String
    }
}

