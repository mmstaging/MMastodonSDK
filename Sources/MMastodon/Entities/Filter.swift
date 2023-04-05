extension MastodonAPI.Entities {
    /// Represents a user-defined filter for determining which statuses should not be shown to the user.
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

        public enum Action: String, Codable, Hashable {
            /// show a warning that identifies the matching filter by title, and allow the user to expand the filtered status. This is the default (and unknown values should be treated as equivalent to warn).
            case warn = "warn"
            /// do not show this status if it is received
            case hide = "hide"
        }

        /// The ID of the Filter in the database.
        public var id: String
        /// A title given by the user to name the filter.
        public var title: String
        /// The contexts in which the filter should be applied.
        public var context: Filter.Context
        /// When the filter should no longer be applied. ISO 8601 Datetime, or null if the filter does not expire
        public var expires_at: String?
        /// The action to be taken when a status matches this filter.
        public var filter_action: Filter.Action
        /// The keywords grouped under this filter.
        public var keywords: [FilterKeyword]
        /// The statuses grouped under this filter.
        public var statuses: [FilterStatus]
    }
}
