extension MastodonAPI.Entities {
    /// Represents an application that interfaces with the REST API to access accounts or post statuses.
    public struct Application: Codable, Hashable {
        /// The name of your application.
        public var name: String
        /// The website associated with your application. (optional)
        public var website: String?
        /// Used for Push Streaming API. Returned with POST /api/v1/apps. Equivalent to WebPushSubscription#server_key (optional)
        public var vapid_key: String?
        /// Client ID key, to be used for obtaining OAuth tokens (optional)
        public var client_id: String?
        /// Client secret key, to be used for obtaining OAuth tokens (optional)
        public var client_secret: String?
    }
}
