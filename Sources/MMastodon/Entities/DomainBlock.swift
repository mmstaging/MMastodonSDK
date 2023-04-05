extension MastodonAPI.Entities {
    /// Represents a domain that is blocked by the instance.
    public struct DomainBlock: Codable, Hashable {
        public enum Severity: String, Codable, Hashable {
            /// Users from this domain will be hidden from timelines, threads, and notifications (unless you follow the user).
            case silence = "silence"
            /// Incoming messages from this domain will be rejected and dropped entirely.
            case suspend = "suspend"
        }

        /// The domain which is blocked. This may be obfuscated or partially censored.
        public var domain: String
        /// The SHA256 hash digest of the domain string.
        public var digest: String
        /// The level to which the domain is blocked.
        public var severity: Severity
        /// An optional reason for the domain block.
        public var comment: String?
    }
}
