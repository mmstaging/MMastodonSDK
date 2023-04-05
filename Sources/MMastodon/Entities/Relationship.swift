extension MastodonAPI.Entities {
    /// Represents the relationship between accounts, such as following / blocking / muting / etc.
    public struct Relationship: Codable, Hashable {
        /// The account ID.
        public var id: String
        /// Are you following this user?
        public var following: Bool
        /// Are you receiving this user’s boosts in your home timeline?
        public var showing_reblogs: Bool
        /// Have you enabled notifications for this user?
        public var notifying: Bool
        /// Which languages are you following from this user?
        public var languages: [String]
        /// Are you followed by this user?
        public var followed_by: Bool
        /// Are you blocking this user?
        public var blocking: Bool
        /// Is this user blocking you?
        public var blocked_by: Bool
        /// Are you muting this user?
        public var muting: Bool
        /// Are you muting notifications from this user?
        public var muting_notifications: Bool
        /// Do you have a pending follow request for this user?
        public var requested: Bool
        /// Are you blocking this user’s domain?
        public var domain_blocking: Bool
        /// Are you featuring this user on your profile?
        public var endorsed: Bool
        /// This user’s profile bio
        public var note: String
    }
}
