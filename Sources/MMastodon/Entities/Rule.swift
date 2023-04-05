extension MastodonAPI.Entities {
    /// Represents a rule that server users should follow.
    public struct Rule: Codable, Hashable {
        /// An identifier for the rule.
        public var id: String
        /// The rule to be followed.
        public var text: String
    }
}
