extension MastodonAPI.Entities {
    /// Represents a poll attached to a status.
    public struct Poll: Codable, Hashable {

        public struct Option: Codable, Hashable {
            /// The text value of the poll option.
            public var title: String
            /// The total number of received votes for this option.
            public var votes_count: Int?
        }

        /// The ID of the poll in the database.
        public var id: String?
        /// When the poll ends. ISO 8601 Datetime, or null if the poll does not end
        public var expires_at: String?
        /// Is the poll currently expired?
        public var expired: Bool
        /// Does the poll allow multiple-choice answers?
        public var multiple: Bool
        /// How many votes have been received.
        public var votes_count: Int
        /// How many unique accounts have voted on a multiple-choice poll.
        public var voters_count: Int?
        /// Possible answers for the poll.
        public var options: [Poll.Option]
        /// Custom emoji to be used for rendering poll options.
        public var emojis: [CustomEmoji]
        /// When called with a user token, has the authorized user voted?
        public var voted: Bool?
        /// When called with a user token, which options has the authorized user chosen? Contains an array of index values for `options`.
        public var own_votes: [Int]?
    }
}
