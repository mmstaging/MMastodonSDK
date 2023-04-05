extension MastodonAPI.Entities {
    /// Represents the software instance of Mastodon running on this domain.
    public struct Instance: Codable, Hashable {
        public struct User: Codable, Hashable {
            /// The number of active users in the past 4 weeks.
            public var active_month: Int
        }

        public struct UsageData: Codable, Hashable {
            /// Usage data related to users on this instance.
            public var users: User
        }

        public struct ThumbnailVersions: Codable, Hashable {
            public enum CodingKeys: String, CodingKey {
                case oneX = "@1x"
                case twoX = "@2x"
            }
            /// The URL for the thumbnail image at 1x resolution.
            public var oneX: String
            /// The URL for the thumbnail image at 2x resolution.
            public var twoX: String
        }

        public struct ThumbailDescription: Codable, Hashable {
            /// The URL for the thumbnail image.
            public var url: String
            /// A hash computed by the BlurHash algorithm, for generating colorful preview thumbnails when media has not been downloaded yet.
            public var blurhash: String?
            /// Links to scaled resolution images, for high DPI screens.
            public var versions: ThumbnailVersions?
        }

        public struct URLs: Codable, Hashable {
            /// The Websockets URL for connecting to the streaming API.
            public var streaming: String
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

        public struct Translation: Codable, Hashable {
            /// Whether the Translations API is available on this instance.
            public var enabled: Bool
        }

        public struct Configuration: Codable, Hashable {
            /// URLs of interest for clients apps.
            public var urls: URLs
            /// Limits related to accounts.
            public var accounts: AccountConfig
            /// Limits related to authoring statuses.
            public var statuses: StatusConfig
            /// Hints for which attachments will be accepted.
            public var media_attachments: MediaAttachmentConfig
            /// Limits related to polls.
            public var polls: PollConfig
            /// Hints related to translation.
            public var translation: Translation
        }

        public struct Registrations: Codable, Hashable {
            /// Whether registrations are enabled.
            public var enabled: Bool
            /// Whether registrations require moderator approval.
            public var approval_required: Bool
            /// A custom message to be shown when registrations are closed.
            public var message: String?
        }

        public struct SiteContact: Codable, Hashable {
            /// An email address that can be messaged regarding inquiries or issues.
            public var email: String
            /// An account that can be contacted natively over the network regarding inquiries or issues.
            public var account: Account
        }

        /// The domain name of the instance.
        public var domain: String
        /// The title of the website.
        public var title: String
        /// The version of Mastodon installed on the instance.
        public var version: String
        /// The URL for the source code of the software running on this instance, in keeping with AGPL license requirements.
        public var source_url: String
        /// A short, plain-text description defined by the admin.
        public var description: String
        /// Usage data for this instance.
        public var usage: UsageData
        /// An image used to represent this instance.
        public var thumbnail: ThumbailDescription
        /// Primary languages of the website and its staff.
        public var languages: [String]
        /// Configured values and limits for this website.
        public var configuration: Configuration
        /// Information about registering for this website.
        public var registrations: Registrations
        /// Hints related to contacting a representative of the website.
        public var contact: SiteContact
        /// An itemized list of rules for this website.
        public var rules: [Rule]
    }
}
