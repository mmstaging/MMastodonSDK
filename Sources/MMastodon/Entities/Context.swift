extension MastodonAPI.Entities {
    /// Represents the tree around a given status. Used for reconstructing threads of statuses.
    public struct Context: Codable, Hashable {
        /// Parents in the thread.
        public var ancestors: [Status]
        /// Children in the thread.
        public var descendants: [Status]
    }
}
