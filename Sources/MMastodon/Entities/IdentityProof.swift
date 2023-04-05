extension MastodonAPI.Entities {
    /// Represents a proof from an external identity provider.
    public struct IdentityProof: Codable, Hashable {
        /// The name of the identity provider.
        public var provider: String
        /// The account owner’s username on the identity provider’s service.
        public var provider_username: String
        /// When the identity proof was last updated.
        public var updated_at: String
        /// A link to a statement of identity proof, hosted by the identity provider.
        public var proof_url: String
        /// The account owner’s profile URL on the identity provider.
        public var profile_url: String
    }
}
