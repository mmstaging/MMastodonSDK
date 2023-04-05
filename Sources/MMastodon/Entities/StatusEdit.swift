extension MastodonAPI.Entities {
    /// Represents a revision of a status that has been edited.
    public struct StatusEdit: Codable, Hashable {

        public struct EditPollOption: Codable, Hashable {
            /// The text for a poll option.
            public var title: String
        }

        public struct EditPoll: Codable, Hashable {
            /// The poll options at this revision.
            public var options: [EditPollOption]
        }

        /// The content of the status at this revision.
        public var content: String
        /// The content of the subject or content warning at this revision.
        public var spoiler_text: String
        /// Whether the status was marked sensitive at this revision.
        public var sensitive: Bool
        /// The timestamp of when the revision was published.
        public var created_at: String
        /// The account that published this revision.
        public var account: Account
        /// The current state of the poll options at this revision. Note that edits changing the poll options will be collapsed together into one edit, since this action resets the poll.
        public var poll: EditPoll
        /// TODO: mistake in documentation - https://docs.joinmastodon.org/entities/StatusEdit/
        public var media_attachments: [MediaAttachment]
        /// Any custom emoji that are used in the current revision.
        public var emojis: [CustomEmoji]
    }
}

