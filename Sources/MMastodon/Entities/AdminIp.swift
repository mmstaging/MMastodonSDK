extension MastodonAPI.Entities.Admin {
    /// Represents an IP address associated with a user.
    public struct Ip: Codable, Hashable {
        /// The IP address.
        public var ip: String
        /// The timestamp of when the IP address was last used for this account.
        public var used_at: String
    }
}
