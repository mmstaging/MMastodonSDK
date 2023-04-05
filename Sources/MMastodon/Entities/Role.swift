extension MastodonAPI.Entities {
    /// Represents a custom user role that grants permissions.
    public struct Role: Codable, Hashable {
        /// The ID of the Role in the database.
        public var id: Int
        /// The name of the role.
        public var name: String
        /// The hex code assigned to this role. If no hex code is assigned, the string will be empty.
        public var color: String
        /// An index for the role’s position. The higher the position, the more priority the role has over other roles.
        public var position: Int
        /// A bitmask that represents the sum of all permissions granted to the role.
        public var permissions: RolePermissions
        /// Whether the role is publicly visible as a badge on user profiles.
        public var highlighted: Bool
        /// The date that the role was created. ISO 8601 Datetime.
        public var created_at: String
        /// The date that the role was updated.
        public var updated_at: String
    }
}
