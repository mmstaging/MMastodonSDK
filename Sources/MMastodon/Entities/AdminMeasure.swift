extension MastodonAPI.Entities.Admin {
    /// Represents quantitative data about the server.
    public struct Measure: Codable, Hashable {

        public struct MeasureData: Codable, Hashable {
            /// Midnight on the requested day in the time period.
            public var date: String
            /// The numeric value for the requested measure.
            public var value: String
        }

        /// The unique keystring for the requested measure.
        public var key: String
        /// The units associated with this data item’s value, if applicable.
        public var unit: String?
        /// The numeric total associated with the requested measure.
        public var total: String
        /// A human-readable formatted value for this data item.
        public var human_value: String
        /// The numeric total associated with the requested measure, in the previous period. Previous period is calculated by subtracting the `start_at` and `end_at` dates, then offsetting both start and end dates backwards by the length of the time period.
        public var previous_total: String
        /// The data available for the requested measure, split into daily buckets.
        public var data: [MeasureData]
    }
}
