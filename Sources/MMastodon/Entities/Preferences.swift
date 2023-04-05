extension MastodonAPI.Entities {
    /// Represents a user's preferences.
    public struct Preferences: Codable, Hashable {
        public enum CodingKeys: String, CodingKey {
            case posting_default_visibility = "posting:default:visibility"
            case posting_default_sensitive = "posting:default:sensitive"
            case posting_default_language = "posting:default:language"
            case reading_expand_media = "reading:expand:media"
            case reading_expand_spoilers = "reading:expand:spoilers"
        }
        
        public enum ExpandMedia: String, Codable, Hashable {
            /// Hide media marked as sensitive
            case `default` = "default"
            /// Always show all media by default, regardless of sensitivity
            case show_all = "show_all"
            /// Always hide all media by default, regardless of sensitivity
            case hide_all = "hide_all"
        }

        /// Default visibility for new posts. Equivalent to CredentialAccount#source[privacy].
        public var posting_default_visibility: PostVisibility
        /// Default sensitivity flag for new posts. Equivalent to CredentialAccount#source[sensitive].
        public var posting_default_sensitive: Bool
        /// Default language for new posts. Equivalent to CredentialAccount#source[language]
        public var posting_default_language: String?
        /// Whether media attachments should be automatically displayed or blurred/hidden.
        public var reading_expand_media: ExpandMedia
        /// Whether CWs should be expanded by default.
        public var reading_expand_spoilers: Bool
    }
}
