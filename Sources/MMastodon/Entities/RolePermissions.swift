extension MastodonAPI.Entities {
    public struct RolePermissions: Codable, Hashable {
        public let rawValue: Int

        /// Users with this permission bypass all permissions.
        public static let administrator = RolePermissions(rawValue: 1 << 0)
        /// Allows users to access Sidekiq and pgHero dashboards.
        public static let devops = RolePermissions(rawValue: 1 << 1)
        /// Allows users to see history of admin actions.
        public static let viewAuditLog = RolePermissions(rawValue: 1 << 2)
        /// Allows users to access the dashboard and various metrics.
        public static let viewDashboard = RolePermissions(rawValue: 1 << 3)
        /// Allows users to review reports and perform moderation actions against them.
        public static let manageReports = RolePermissions(rawValue: 1 << 4)
        /// Allows users to block or allow federation with other domains, and control deliverability.
        public static let manageFederation = RolePermissions(rawValue: 1 << 5)
        /// Allows users to change site settings.
        public static let manageSettings = RolePermissions(rawValue: 1 << 6)
        /// Allows users to block e-mail providers and IP addresses.
        public static let manageBlocks = RolePermissions(rawValue: 1 << 7)
        /// Allows users to review trending content and update hashtag settings.
        public static let manageTaxonomies = RolePermissions(rawValue: 1 << 8)
        /// Allows users to review appeals against moderation actions.
        public static let manageAppeals = RolePermissions(rawValue: 1 << 9)
        /// Allows users to view other users’ details and perform moderation actions against them.
        public static let manageUsers = RolePermissions(rawValue: 1 << 10)
        /// Allows users to browse and deactivate invite links.
        public static let manageInvites = RolePermissions(rawValue: 1 << 11)
        /// Allows users to change server rules.
        public static let manageRules = RolePermissions(rawValue: 1 << 12)
        /// Allows users to manage announcements on the server.
        public static let manageAnnouncements = RolePermissions(rawValue: 1 << 13)
        /// Allows users to manage custom emojis on the server.
        public static let manageCustomEmojis = RolePermissions(rawValue: 1 << 14)
        /// Allows users to set up webhooks for administrative events.
        public static let manageWebhooks = RolePermissions(rawValue: 1 << 15)
        /// Allows users to invite new people to the server.
        public static let inviteUsers = RolePermissions(rawValue: 1 << 16)
        /// Allows users to manage and assign roles below theirs.
        public static let manageRoles = RolePermissions(rawValue: 1 << 17)
        /// Allows users to disable other users’ two-factor authentication, change their e-mail address, and reset their password.
        public static let manageUserAccess = RolePermissions(rawValue: 1 << 18)
        /// Allows users to delete other users’ data without delay.
        public static let deleteUserData = RolePermissions(rawValue: 1 << 19)
    }
}
