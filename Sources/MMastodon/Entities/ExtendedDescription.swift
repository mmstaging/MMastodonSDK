extension MastodonAPI.Entities {
    /// Represents an extended description for the instance, to be shown on its about page.
    public struct ExtendedDescription: Codable, Hashable {
        /// A timestamp of when the extended description was last updated.
        public var updated_at: String
        /// A timestamp of when the extended description was last updated.
        public var content: String
    }
}
