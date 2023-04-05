extension MastodonAPI.Entities.Admin {
    public struct DimensionAttribute: Codable, Hashable {
        /// The unique keystring for this data item.
        public var key: String
        /// A human-readable key for this data item.
        public var human_key: String
        /// The value for this data item.
        public var value: String
        /// The units associated with this data item’s value, if applicable.
        public var unit: String?
        /// A human-readable formatted value for this data item.
        public var human_value: String?
    }

    /// Represents a canonical email block (hashed).
    public struct Dimension: Codable, Hashable {
        /// The unique keystring for the requested dimension.
        public var key: String
        /// The data available for the requested dimension.
        public var data: [DimensionAttribute]
    }
}
