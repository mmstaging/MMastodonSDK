extension MastodonAPI.Entities.Admin {
    /// Admin-level information about a given account.
    public struct Account: Codable, Hashable {
        /// The ID of the account in the database.
        public var id: String
        /// The username of the account.
        public var username: String
        /// The domain of the account, if it is remote.
        public var domain: String?
        /// When the account was first discovered.
        public var created_at: String
        /// The email address associated with the account.
        public var email: String
        /// The IP address last used to login to this account.
        public var ip: String?
        /// All known IP addresses associated with this account.
        public var ips: [Ip]
        /// The locale of the account.
        public var locale: String
        /// The reason given when requesting an invite (for instances that require manual approval of registrations)
        public var invite_request: String?
        /// The current role of the account.
        public var role: MastodonAPI.Entities.Role
        /// Whether the account has confirmed their email address.
        public var confirmed: Bool
        /// Whether the account is currently approved.
        public var approved: Bool
        /// Whether the account is currently disabled.
        public var disabled: Bool
        /// Whether the account is currently silenced.
        public var silenced: Bool
        /// Whether the account is currently suspended.
        public var suspended: Bool
        /// User-level information about the account.
        public var account: MastodonAPI.Entities.Account
        /// The ID of the Application that created this account, if applicable.
        public var created_by_application_id: String?
        /// The ID of the Account that invited this user, if applicable.
        public var invited_by_account_id: String?
    }
}
