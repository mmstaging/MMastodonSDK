extension MastodonAPI.Entities {
    /// Represents an error message.
    public struct Error: Codable, Hashable {
        /// The error message.
        public var error: String
        /// A longer description of the error, mainly provided with the OAuth API.
        public var error_description: String?
    }
}
