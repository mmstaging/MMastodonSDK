extension MastodonAPI.Entities {
    /// Represents an OAuth token used for authenticating with the API and performing actions.
    public struct Token: Codable, Hashable {
        /// An OAuth token to be used for authorization.
        public var access_token: String
        /// The OAuth token type. Mastodon uses `Bearer` tokens.
        public var token_type: String
        /// The OAuth scopes granted by this token, space-separated.
        public var scope: String
        /// When the token was generated.
        public var created_at: Double
    }
}
