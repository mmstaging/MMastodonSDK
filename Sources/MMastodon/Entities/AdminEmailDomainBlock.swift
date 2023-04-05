extension MastodonAPI.Entities.Admin {
    /// Represents an email domain that cannot be used to sign up.
    public struct EmailDomainBlock: Codable, Hashable {
        public struct History: Codable, Hashable {
            /// UNIX timestamp on midnight of the given day.
            public var day: String
            /// The counted accounts signup attempts using that email domain within that day.
            public var accounts: String
            /// The counted IP signup attempts of that email domain within that day.
            public var uses: String
        }
        /// The ID of the EmailDomainBlock in the database.
        public var id: String
        /// The email domain that is not allowed to be used for signups.
        public var domain: String
        /// When the email domain was disallowed from signups.
        public var created_at: String
        /// Usage statistics for given days (typically the past week).
        public var history: [History]
    }
}
