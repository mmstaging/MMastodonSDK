extension MastodonAPI.Entities.V1 {
    /// Represents the software instance of Mastodon running on this domain.
    public struct Instance: Codable, Hashable {

        public struct URLs: Codable, Hashable {
            /// The Websockets URL for connecting to the streaming API.
            public var streaming_api: String
        }

        public struct Stats: Codable, Hashable {
            /// Total users on this instance.
            public var user_count: Int
            /// Total statuses on this instance.
            public var status_count: Int
            /// Total domains discovered by this instance.
            public var domain_count: Int
        }

        public struct AccountConfig: Codable, Hashable {
            /// The maximum number of featured tags allowed for each account.
            public var max_featured_tags: Int
        }

        public struct StatusConfig: Codable, Hashable {
            /// The maximum number of allowed characters per status.
            public var max_characters: Int
            /// The maximum number of media attachments that can be added to a status.
            public var max_media_attachments: Int
            /// Each URL in a status will be assumed to be exactly this many characters.
            public var characters_reserved_per_url: Int
        }

        public struct MediaAttachmentConfig: Codable, Hashable {
            /// Contains MIME types that can be uploaded.
            public var supported_mime_types: [String]
            /// The maximum size of any uploaded image, in bytes.
            public var image_size_limit: Int
            /// The maximum number of pixels (width times height) for image uploads.
            public var image_matrix_limit: Int
            /// The maximum size of any uploaded video, in bytes.
            public var video_size_limit: Int
            /// The maximum frame rate for any uploaded video.
            public var video_frame_rate_limit: Int
            /// The maximum number of pixels (width times height) for video uploads.
            public var video_matrix_limit: Int
        }

        public struct PollConfig: Codable, Hashable {
            /// Each poll is allowed to have up to this many options.
            public var max_options: Int
            /// Each poll option is allowed to have this many characters.
            public var max_characters_per_option: Int
            /// The shortest allowed poll duration, in seconds.
            public var min_expiration: Int
            /// The longest allowed poll duration, in seconds.
            public var max_expiration: Int
        }

        public struct Configuration: Codable, Hashable {
            /// Limits related to accounts.
            public var accounts: AccountConfig
            /// Limits related to authoring statuses.
            public var statuses: StatusConfig
            /// Hints for which attachments will be accepted.
            public var media_attachments: MediaAttachmentConfig
            /// Limits related to polls.
            public var polls: PollConfig
        }


        /// The domain name of the instance.
        public var uri: String
        /// The title of the website.
        public var title: String
        /// A short, plain-text description defined by the admin.
        public var short_description: String
        /// An HTML-permitted description of the Mastodon site.
        public var description: String
        /// An email that may be contacted for any inquiries.
        public var email: String
        /// The version of Mastodon installed on the instance.
        public var version: String
        /// URLs of interest for clients apps.
        public var urls: URLs
        /// Statistics about how much information the instance contains.
        public var stats: Stats
        /// Banner image for the website.
        public var thumbnail: String?
        /// Primary languages of the website and its staff.
        public var languages: [String]
        /// Whether registrations are enabled.
        public var registrations: Bool
        /// Whether registrations require moderator approval.
        public var approval_required: Bool
        /// Whether invites are enabled.
        public var invites_enabled: Bool
        /// Configured values and limits for this website.
        public var configuration: Configuration
        /// A user that can be contacted, as an alternative to `email`.
        public var contact_account: MastodonAPI.Entities.Account
        /// An itemized list of rules for this website.
        public var rules: [MastodonAPI.Entities.Rule]
    }
}
