extension MastodonAPI.Entities.Admin {
    /// Represents a canonical email block (hashed).
    public struct CanonicalEmailBlock: Codable, Hashable {
        /// The ID of the email block in the database.
        public var id: String
        /// The SHA256 hash of the canonical email address.
        public var canonical_email_hash: String
    }
}
