extension MastodonAPI.Entities.Admin {
    /// Represents an IP address range that cannot be used to sign up.
    public struct IpBlock: Codable, Hashable {
        public enum Severity: String, Codable, Hashable {
            /// Any signup from this IP range will create a pending account
            case sign_up_requires_approval = "sign_up_requires_approval"
            /// Any signup from this IP range will be rejected
            case sign_up_block = "sign_up_block"
            /// Any activity from this IP range will be rejected entirely
            case no_access = "no_access"
        }

        /// The ID of the DomainBlock in the database.
        public var id: String
        /// The IP address range that is not allowed to federate.
        public var ip: String
        /// The associated policy with this IP block.
        public var severity: Severity
        /// The recorded reason for this IP block.
        public var comment: String
        /// When the IP block was created.
        public var created_at: String
        /// When the IP block will expire.
        public var expires_at: String?
    }
}
