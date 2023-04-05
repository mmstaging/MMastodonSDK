extension MastodonAPI.Entities {
    /// Represents a subscription to the push streaming server.
    public struct WebPushSubscription: Codable, Hashable {

        public struct AdminAlertSubscription: Codable, Hashable {
            /// Receive a push notification when a new user has signed up?
            public var sign_up: Bool
            /// Receive a push notification when a new report has been filed?
            public var report: Bool
        }

        public struct AlertSubscription: Codable, Hashable {
            /// Receive a push notification when someone else has mentioned you in a status?
            public var mention: Bool
            /// Receive a push notification when a subscribed account posts a status?
            public var status: Bool
            /// Receive a push notification when a status you created has been boosted by someone else?
            public var reblog: Bool
            /// Receive a push notification when someone has followed you?
            public var follow: Bool
            /// Receive a push notification when someone has requested to followed you?
            public var follow_request: Bool
            /// Receive a push notification when a status you created has been favourited by someone else?
            public var favourite: Bool
            /// Receive a push notification when a poll you voted in or created has ended?
            public var poll: Bool
            /// Receive a push notification when a status you interacted with has been edited?
            public var update: Bool
            ///
            public var admin: AdminAlertSubscription
        }

        /// The ID of the Web Push subscription in the database.
        public var id: String
        /// Where push alerts will be sent to.
        public var endpoint: String
        /// The streaming server’s VAPID key.
        public var server_key: String
        /// Which alerts should be delivered to the `endpoint`.
        public var alerts: AlertSubscription
    }
}
