extension MastodonAPI.Entities {
    /// Represents a status ID that, if matched, should cause the filter action to be taken.
    public struct FilterStatus: Codable, Hashable {
        /// The ID of the FilterStatus in the database.
        public var id: String
        /// The ID of the filtered Status in the database.
        public var status_id: String
    }
}
