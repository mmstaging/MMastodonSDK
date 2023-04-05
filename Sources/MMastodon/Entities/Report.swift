extension MastodonAPI.Entities {
    /// Reports filed against users and/or statuses, to be taken action on by moderators.
    public struct Report: Codable, Hashable {

        public enum Category: String, Codable, Hashable {
            /// Unwanted or repetitive content
            case spam = "spam"
            /// A specific rule was violated
            case violation = "violation"
            /// Some other reason
            case other = "other"
        }

        /// The ID of the report in the database.
        public var id: String
        /// Whether an action was taken yet.
        public var action_taken: Bool
        /// When an action was taken against the report.
        public var action_taken_at: String?
        /// The generic reason for the report.
        public var category: Category
        /// The reason for the report.
        public var comment: String
        /// Whether the report was forwarded to a remote domain.
        public var forwarded: Bool
        /// When the report was created.
        public var created_at: String
        /// TODO: docs incorrect.  https://docs.joinmastodon.org/entities/Report/
        public var status_ids: [String]?
        /// TODO: docs incorrect.  https://docs.joinmastodon.org/entities/Report/
        public var rule_ids: [String]?
        /// The account that was reported.
        public var target_account: Account
    }
}
