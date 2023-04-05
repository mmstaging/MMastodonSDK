extension MastodonAPI.Entities {
    public struct Field: Codable, Hashable {
        /// The key of a given field’s key-value pair.
        public var name: String
        /// The value associated with the `name` key.
        public var value: String
        /// Timestamp of when the server verified a URL value for a rel=“me” link. ISO 8601 Datetime if value is a verified URL. Otherwise, null.
        public var verified_at: String?
    }
}
