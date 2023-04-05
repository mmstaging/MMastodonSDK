extension MastodonAPI.Entities.V1 {
    /// Represents a user-defined filter for determining which statuses should not be shown to the user. Contains a single keyword or phrase.
    public struct Filter: Codable, Hashable {

        public enum Context: String, Codable, Hashable {
            /// home timeline and lists
            case home = "home"
            /// notifications timeline
            case notifications = "notifications"
            /// public timelines
            case `public` = "public"
            /// expanded thread of a detailed status
            case thread = "thread"
            /// when viewing a profile
            case account = "account"
        }

        /// The ID of the filter in the database.
        public var id: String
        /// The text to be filtered.
        public var phrase: String
        /// The contexts in which the filter should be applied.
        public var context: Context
        /// When the filter should no longer be applied.
        public var expires_at: String?
        /// Should matching entities in home and notifications be dropped by the server? See implementation guidelines for filters.
        public var irreversible: Bool
        /// Should the filter consider word boundaries? See implementation guidelines for filters.
        public var whole_word: Bool
    }
}
