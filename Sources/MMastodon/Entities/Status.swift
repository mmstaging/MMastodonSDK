extension MastodonAPI.Entities {
    /// Represents a status posted by an account.
    public class Status: Codable, Hashable {
        public struct Mention: Codable, Hashable {
            /// The account ID of the mentioned user.
            public var id: String
            /// The username of the mentioned user.
            public var username: String
            /// The location of the mentioned user’s profile.
            public var url: String
            /// The webfinger acct: URI of the mentioned user. Equivalent to username for local users, or username@domain for remote users.
            public var acct: String
        }

        public struct Tag: Codable, Hashable {
            /// The value of the hashtag after the # sign.
            public var name: String
            /// A link to the hashtag on the instance.
            public var url: String
        }

        /// ID of the status in the database.
        public var id: String
        /// URI of the status used for federation.
        public var uri: String
        /// The date when this status was created. ISO 8601 Datetime
        public var created_at: String
        /// The account that authored this status.
        public var account: Account
        /// HTML-encoded status content.
        public var content: String
        /// Visibility of this status.
        public var visibility: PostVisibility
        /// Is this status marked as sensitive content?
        public var sensitive: Bool
        /// Subject or summary line, below which status content is collapsed until expanded.
        public var spoiler_text: String
        /// Media that is attached to this status.
        public var media_attachments: [MediaAttachment]
        /// The application used to post this status.
        public var application: Application?
        /// Mentions of users within the status content.
        public var mentions: [Status.Mention]
        /// Hashtags used within the status content.
        public var tags: [Status.Tag]
        /// Custom emoji to be used when rendering status content.
        public var emojis: [CustomEmoji]
        /// How many boosts this status has received.
        public var reblogs_count: Int
        /// How many favourites this status has received.
        public var favourites_count: Int
        /// How many replies this status has received.
        public var replies_count: Int
        /// A link to the status’s HTML representation.
        public var url: String?
        /// ID of the status being replied to.
        public var in_reply_to_id: String?
        /// ID of the account that authored the status being replied to.
        public var in_reply_to_account_id: String?
        /// The status being reblogged.
        public var reblog: Status?
        /// The poll attached to the status.
        public var poll: Poll?
        /// Preview card for links included within status content.
        public var card: PreviewCard?
        /// Primary language of this status. ISO 639 Part 1 two-letter language code, or null
        public var language: String?
        /// Plain-text source of a status. Returned instead of content when status is deleted, so the user may redraft from the source text without the client having to reverse-engineer the original text from the HTML content.
        public var text: String?
        /// Timestamp of when the status was last edited. ISO 8601 Datetime or null
        public var edited_at: String?
        /// If the current token has an authorized user: Have you favourited this status?
        public var favourited: Bool?
        /// If the current token has an authorized user: Have you boosted this status?
        public var reblogged: Bool?
        /// If the current token has an authorized user: Have you muted notifications for this status’s conversation?
        public var muted: Bool?
        /// If the current token has an authorized user: Have you bookmarked this status?
        public var bookmarked: Bool?
        /// If the current token has an authorized user: Have you pinned this status? Only appears if the status is pinnable.
        public var pinned: Bool?
        /// If the current token has an authorized user: The filter and keywords that matched this status.
        public var filtered: [FilterResult]?

        public static func ==(lhs: Status, rhs: Status) -> Bool {
            return lhs.id == rhs.id
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
}
