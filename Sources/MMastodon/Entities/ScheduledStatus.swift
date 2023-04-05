extension MastodonAPI.Entities {
    /// Represents a status that will be published at a future scheduled date.
    public struct ScheduledStatus: Codable, Hashable {
        public struct Params: Codable, Hashable {
            /// Text to be used as status content.
            public var text: String
            /// Poll to be attached to the status.
            public var poll: Poll?
            /// IDs of the MediaAttachments that will be attached to the status.
            public var media_ids: [String]?
            /// Whether the status will be marked as sensitive.
            public var sensitive: Bool?
            /// The text of the content warning or summary for the status.
            public var spoiler_text: String?
            /// Visibility of this status.
            public var visibility: PostVisibility
            /// ID of the Status that will be replied to.
            public var in_reply_to_id: Int?
            /// The language that will be used for the status.
            public var language: String?
            /// ID of the Application that posted the status.
            public var application_id: Int
            /// When the status will be scheduled. This will be null because the status is only scheduled once.
            public var scheduled_at: String?
            /// Idempotency key to prevent duplicate statuses.
            public var idempotency: String?
            /// Whether the status should be rate limited .
            public var with_rate_limit: Bool
        }

        /// ID of the scheduled status in the database.
        public var id: String
        /// ID of the status in the database.
        public var scheduled_at: String
        /// The parameters that were used when scheduling the status, to be used when the status is posted.
        public var params: Params
        /// Media that will be attached when the status is posted.
        public var media_attachments: [MediaAttachment]
    }
}
