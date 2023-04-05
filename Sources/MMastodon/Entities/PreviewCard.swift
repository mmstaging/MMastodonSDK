extension MastodonAPI.Entities {
    /// Represents a rich preview card that is generated using OpenGraph tags from a URL.
    public struct PreviewCard: Codable, Hashable {

        public enum PreviewCardType: String, Codable, Hashable {
            /// Link OEmbed
            case link = "link"
            /// Photo OEmbed
            case photo = "photo"
            /// Video OEmbed
            case video = "video"
            /// iframe OEmbed. Not currently accepted, so won’t show up in practice.
            case rich = "rich"
        }

        /// Location of linked resource.
        public var url: String
        /// Title of linked resource.
        public var title: String
        /// Description of preview.
        public var description: String
        /// The type of the preview card.
        public var type: PreviewCard.PreviewCardType
        /// The author of the original resource.
        public var author_name: String
        /// A link to the author of the original resource.
        public var author_url: String
        /// The provider of the original resource.
        public var provider_name: String
        /// A link to the provider of the original resource.
        public var provider_url: String
        /// HTML to be used for generating the preview card.
        public var html: String
        /// Width of preview, in pixels.
        public var width: Int
        /// Height of preview, in pixels.
        public var height: Int
        /// Preview thumbnail.
        public var image: String?
        /// Used for photo embeds, instead of custom `html`.
        public var embed_url: String
        /// A hash computed by the BlurHash algorithm, for generating colorful preview thumbnails when media has not been downloaded yet.
        public var blurhash: String?
    }
}
