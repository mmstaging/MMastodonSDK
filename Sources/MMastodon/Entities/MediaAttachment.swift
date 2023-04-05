extension MastodonAPI.Entities {
    /// Represents a file or media attachment that can be added to a status.
    public struct MediaAttachment: Codable, Hashable {

        public struct MetaFocus: Codable, Hashable {
            public var x: Double?
            public var y: Double?
        }

        public struct MetaOriginal: Codable, Hashable {
            public var length: String?
            public var duration: Double?
            public var audio_encode: String?
            public var audio_bitrate: String?
            public var audio_channels: String?
            public var width: Int?
            public var height: Int?
            public var size: String?
            public var aspect: Double?
        }

        public struct Meta: Codable, Hashable {
            public var length: String?
            public var duration: Double?
            public var audio_encode: String?
            public var audio_bitrate: String?
            public var audio_channels: String?
            public var original: MetaOriginal?
            public var small: MetaOriginal?
            public var focus: MetaFocus?
        }

        public enum MediaType: String, Codable, Hashable {
            /// unsupported or unrecognized file type
            case unknown = "unknown"
            /// Static image
            case image = "image"
            /// Looping, soundless animation
            case gifv = "gifv"
            /// Video clip
            case video = "video"
            /// Audio track
            case audio = "audio"
        }

        /// The ID of the attachment in the database.
        public var id: String
        /// The type of the attachment.
        public var type: MediaAttachment.MediaType
        /// The location of the original full-size attachment.
        public var url: String
        /// The location of a scaled-down preview of the attachment.
        public var preview_url: String
        /// The location of the full-size original attachment on the remote website.
        public var remote_url: String?
        /// Metadata returned by Paperclip.
        public var meta: MediaAttachment.Meta
        /// Alternate text that describes what is in the media attachment, to be used for the visually impaired or when media attachments do not load.
        public var description: String?
        /// A hash computed by the BlurHash algorithm, for generating colorful preview thumbnails when media has not been downloaded yet.
        public var blurhash: String
    }
}
