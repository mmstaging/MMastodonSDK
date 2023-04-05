extension MastodonAPI.Entities {
    /// Represents a user of Mastodon and their associated profile.
    public class Account: Codable, Hashable {
        /// The account id.
        public var id: String
        /// The username of the account, not including domain.
        public var username: String
        /// The Webfinger account URI. Equal to username for local users, or username@domain for remote users.
        public var acct: String
        /// The location of the user’s profile page.
        public var url: String
        /// The profile’s display name.
        public var display_name: String
        /// The profile’s bio or description.
        public var note: String
        /// An image icon that is shown next to statuses and in the profile.
        public var avatar: String
        /// A static version of the avatar. Equal to avatar if its value is a static image; different if avatar is an animated GIF.
        public var avatar_static: String
        /// An image banner that is shown above the profile and in profile cards.
        public var header: String
        /// A static version of the header. Equal to header if its value is a static image; different if header is an animated GIF.
        public var header_static: String
        /// Whether the account manually approves follow requests.
        public var locked: Bool
        /// Additional metadata attached to a profile as name-value pairs.
        public var fields: [Field]
        /// Custom emoji entities to be used when rendering the profile.
        public var emojis: [CustomEmoji]
        /// Indicates that the account may perform automated actions, may not be monitored, or identifies as a robot.
        public var bot: Bool
        /// Indicates that the account represents a Group actor.
        public var group: Bool
        /// Whether the account has opted into discovery features such as the profile directory.
        public var discoverable: Bool?
        /// Whether the local user has opted out of being indexed by search engines. (optional)
        public var noindex: Bool?
        /// Indicates that the profile is currently inactive and that its user has moved to a new account. (optional, null if the profile is suspended.)
        public var moved: Account?
        /// An extra attribute returned only when an account is suspended. (optional)
        public var suspended: Bool?
        /// An extra attribute returned only when an account is silenced. If true, indicates that the account should be hidden behind a warning screen. (optional)
        public var limited: Bool?
        /// When the account was created. Now resolves to midnight instead of an exact time. ISO 8601 Datetime
        public var created_at: String
        /// When the most recent status was posted. ISO 8601 Date, or null if no statuses
        public var last_status_at: String?
        /// How many statuses are attached to this account.
        public var statuses_count: Int
        /// The reported followers of this profile.
        public var followers_count: Int
        /// The reported follows of this profile.
        public var following_count: Int

        public struct Source: Codable, Hashable {
            /// Profile bio, in plain-text instead of in HTML.
            public var note: String
            /// Metadata about the account.
            public var fields: [Field]
            /// The default post privacy to be used for new statuses.
            public var privacy: PostVisibility
            /// Whether new statuses should be marked sensitive by default.
            public var sensitive: Bool
            /// The default posting language for new statuses. ISO 639-1 language two-letter code, or empty string
            public var language: String
            /// The number of pending follow requests.
            public var follow_requests_count: Int
        }

        /// When a timed mute will expire, if applicable.
        public var mute_expires_at: String? // Empty if not muted. ISO 8601 Datetime, or null if the mute is indefinite


        /// An extra attribute that contains source values to be used with API methods that verify credentials and update credentials.
        public var source: Source?
        /// The role assigned to the currently authorized user.
        public var role: Role?


        public static func ==(lhs: Account, rhs: Account) -> Bool {
            return lhs.id == rhs.id
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
}
