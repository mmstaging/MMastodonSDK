extension MastodonAPI.Entities {
    /// Represents a conversation with "direct message" visibility.
    public struct Conversation: Codable, Hashable {
        /// The ID of the conversation in the database.
        public var id: String
        /// Is the conversation currently marked as unread?
        public var unread: Bool
        /// Participants in the conversation.
        public var accounts: [Account]
        /// The last status in the conversation.
        public var last_status: Status?
    }
}
