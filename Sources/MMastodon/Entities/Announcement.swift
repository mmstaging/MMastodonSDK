extension MastodonAPI.Entities {
    /// Represents an announcement set by an administrator.
    public struct Announcement: Codable, Hashable {

        public struct Account: Codable, Hashable {
            /// The account ID of the mentioned user.
            public var id: String
            /// The username of the mentioned user.
            public var username: String
            /// The location of the mentioned user’s profile.
            public var url: String
            /// The webfinger acct: URI of the mentioned user. Equivalent to `username` for local users, or `username@domain` for remote users.
            public var acct: String
        }

        public struct Status: Codable, Hashable {
            /// The ID of an attached Status in the database.
            public var id: String
            /// The URL of an attached Status.
            public var url: String
        }

        /// The ID of the announcement in the database.
        public var id: String
        /// The text of the announcement.
        public var content: String
        /// When the announcement will start.
        public var starts_at: String?
        /// When the announcement will end.
        public var ends_at: String?
        /// Whether the announcement is currently active.
        public var published: Bool
        /// Whether the announcement should start and end on dates only instead of datetimes. Will be false if there is no `starts_at` or `ends_at` time.
        public var all_day: Bool
        /// When the announcement was published.
        public var published_at: String
        /// When the announcement was last updated.
        public var updated_at: String
        /// Whether the announcement has been read by the current user.
        public var read: Bool?
        /// Accounts mentioned in the announcement text.
        public var mentions: [Account]
        /// Statuses linked in the announcement text.
        public var statuses: [Status]
        /// Tags linked in the announcement text.
        public var tags: [MastodonAPI.Entities.Status.Tag]
        /// Custom emoji used in the announcement text.
        public var emojis: [CustomEmoji]
        /// Emoji reactions attached to the announcement.
        public var reactions: [Reaction]
    }
}
