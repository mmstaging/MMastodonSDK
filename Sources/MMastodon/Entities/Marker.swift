extension MastodonAPI.Entities {
    /// Represents the last read position within a user's timelines.
    public struct Marker: Codable, Hashable {
        /// The ID of the most recently viewed entity.
        public var last_read_id: String
        /// An incrementing counter, used for locking to prevent write conflicts.
        public var version: Int
        /// The timestamp of when the marker was set.
        public var updated_at: String
    }
}
