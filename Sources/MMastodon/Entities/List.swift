extension MastodonAPI.Entities {
    /// Represents a list of some users that the authenticated user follows.
    public struct List: Codable, Hashable {

        public enum RepliesPolicy: String, Codable, Hashable {
            /// Show replies to any followed user
            case followed = "followed"
            /// Show replies to members of the list
            case list = "list"
            /// Show replies to no one
            case none = "none"
        }

        /// The internal database ID of the list.
        public var id: String
        /// The user-defined title of the list.
        public var title: String
        /// Which replies should be shown in the list.
        public var replies_policy: RepliesPolicy
    }
}
