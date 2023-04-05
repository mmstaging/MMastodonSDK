extension MastodonAPI.Entities.Admin {
    /// Represents a canonical email block (hashed).
    public struct DomainAllow: Codable, Hashable {
        /// The ID of the DomainAllow in the database.
        public var id: String
        /// The domain that is allowed to federate.
        public var domain: String
        /// When the domain was allowed to federate.
        public var created_at: String
    }
}
