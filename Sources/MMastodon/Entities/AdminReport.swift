extension MastodonAPI.Entities.Admin {
    /// Admin-level information about a filed report.
    public struct Report: Codable, Hashable {
        public enum Category: String, Codable, Hashable {
            /// Malicious, fake, or repetitive content
            case spam = "spam"
            /// Violates one or more specific `rules`
            case violation = "violation"
            /// The default (catch-all) category
            case other = "other"
        }

        /// The ID of the report in the database.
        public var id: String
        /// Whether an action was taken to resolve this report.
        public var action_taken: Bool
        /// When an action was taken, if this report is currently resolved.
        public var action_taken_at: String?
        /// The category under which the report is classified.
        public var category: Category
        /// An optional reason for reporting.
        public var comment: String
        /// Whether a report was forwarded to a remote instance.
        public var forwarded: Bool
        /// The time the report was filed.
        public var created_at: String
        /// The time of last action on this report.
        public var updated_at: String
        /// The account which filed the report.
        public var account: MastodonAPI.Entities.Admin.Account
        /// The account being reported.
        public var target_account: MastodonAPI.Entities.Admin.Account
        /// The account of the moderator assigned to this report.
        public var assigned_account: MastodonAPI.Entities.Admin.Account?
        /// The account of the moderator who handled the report.
        public var action_taken_by_account: MastodonAPI.Entities.Admin.Account?
        /// Statuses attached to the report, for context.
        public var statuses: [MastodonAPI.Entities.Status]
        /// Rules attached to the report, for context.
        public var rules: [MastodonAPI.Entities.Rule]
    }
}
