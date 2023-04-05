extension MastodonAPI.Entities {
    /// Represents the results of a search.
    public struct Search: Codable, Hashable {
        /// Accounts which match the given query
        public var accounts: [Account]
        /// Statuses which match the given query
        public var statuses: [Status]
        /// Hashtags which match the given query
        public var hashtags: [Tag]
    }
}
