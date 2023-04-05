extension MastodonAPI.Entities {
    /// Represents a subset of your follows who also follow some other user.
    public struct FamiliarFollowers: Codable, Hashable {
        /// The ID of the Account in the database.
        public var id: String
        /// Accounts you follow that also follow this account.
        public var accounts: [Account]
    }
}
