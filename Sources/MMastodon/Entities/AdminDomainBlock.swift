extension MastodonAPI.Entities.Admin {
    /// Represents a canonical email block (hashed).
    public struct DomainBlock: Codable, Hashable {
        public enum Severity: String, Codable, Hashable {
            /// Account statuses from this domain will be hidden by default
            case silence = "silence"
            /// All incoming data from this domain will be rejected
            case suspend = "suspend"
            /// Do nothing. Allows for rejecting media or reports
            case noop = "noop"
        }

        /// The ID of the DomainAllow in the database.
        public var id: String
        /// The domain that is allowed to federate.
        public var domain: String
        /// When the domain was allowed to federate.
        public var created_at: String
        /// The policy to be applied by this domain block.
        public var severity: Severity
        /// Whether to reject media attachments from this domain
        public var reject_media: Bool
        /// Whether to reject reports from this domain
        public var reject_reports: Bool
        ///
        public var private_comment: String?
        ///
        public var public_comment: String?
        /// Whether to obfuscate public displays of this domain block
        public var obfuscate: Bool
    }
}
