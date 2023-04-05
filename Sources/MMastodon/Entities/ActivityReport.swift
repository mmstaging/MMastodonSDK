extension MastodonAPI.Entities {
    /// Represents activity statistics for a time period on an instance.
    public struct ActivityReport: Codable, Hashable {
        public var week: String?
        public var statuses: String?
        public var logins: String?
        public var registrations: String?
    }
}
