extension MastodonAPI.Entities {
    /// Represents a suggested account to follow and an associated reason for the suggestion.
    public struct Suggestion: Codable, Hashable {
    
        public enum SuggestionReason: String, Codable, Hashable {
            /// This account was manually recommended by your administration team
            case staff = "staff"
            /// You have interacted with this account previously
            case past_interactions = "past_interactions"
            /// This account has many reblogs, favourites, and active local followers within the last 30 days
            case global = "global"
        }

        /// The reason this account is being suggested.
        public var source: SuggestionReason
        /// The account being recommended to follow.
        public var account: Account
    }
}
