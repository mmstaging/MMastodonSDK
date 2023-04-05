extension MastodonAPI.Entities {
    /// Represents a hashtag used within the content of a status.
    public struct Tag: Codable, Hashable {

        public struct History: Codable, Hashable {
            /// UNIX timestamp on midnight of the given day.
            public var day: String
            /// The counted usage of the tag within that day.
            public var uses: String
            /// The total of accounts using the tag within that day.
            public var accounts: String
        }

        /// The value of the hashtag after the # sign.
        public var name: String
        /// A link to the hashtag on the instance.
        public var url: String
        /// Usage statistics for given days (typically the past week).
        public var history: [History]
        /// Whether the current token’s authorized user is following this tag.
        public var following: Bool?
    }
}
