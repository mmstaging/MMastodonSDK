extension MastodonAPI.Entities {
    public enum PostVisibility: String, Codable, Hashable {
        /// Visible to everyone, shown in public timelines.
        case `public` = "public"
        /// Visible to public, but not included in public timelines.
        case unlisted = "unlisted"
        /// Visible to followers only, and to any mentioned users.
        case `private` = "private"
        /// Visible only to mentioned users.
        case direct = "direct"
    }
}
