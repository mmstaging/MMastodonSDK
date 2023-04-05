extension MastodonAPI.Entities {

    public enum NotificationType: String, Codable, Hashable {
        /// Someone mentioned you in their status
        case mention = "mention"
        /// Someone you enabled notifications for has posted a status
        case status = "status"
        /// Someone boosted one of your statuses
        case reblog = "reblog"
        /// Someone followed you
        case follow = "follow"
        /// Someone requested to follow you
        case follow_request = "follow_request"
        /// Someone favourited one of your statuses
        case favourite = "favourite"
        /// A poll you have voted in or created has ended
        case poll = "poll"
        /// A status you interacted with has been edited
        case update = "update"
        /// Someone signed up (optionally sent to admins)
        case admin_sign_up = "admin.sign_up"
        /// A new report has been filed
        case admin_report = "admin.report"
    }

    /// Represents a notification of an event relevant to the user.
    public struct Notification: Codable, Hashable {

        /// The id of the notification in the database.
        public var id: String
        /// The type of event that resulted in the notification.
        public var type: NotificationType
        /// The timestamp of the notification.
        public var created_at: String
        /// The account that performed the action that generated the notification.
        public var account: Account
        /// Status that was the object of the notification. Attached when type of the notification is `favourite`, `reblog`, `status`, `mention`, `poll`, or `update`.
        public var status: Status?
        /// Report that was the object of the notification. Attached when type of the notification is `admin.report`.
        public var report: Report?
    }
}
