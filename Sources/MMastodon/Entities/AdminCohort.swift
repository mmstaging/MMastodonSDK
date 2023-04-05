extension MastodonAPI.Entities.Admin {
    public struct CohortData: Codable, Hashable {
        /// The timestamp for the start of the bucket, at midnight.
        public var date: String
        /// The percentage rate of users who registered in the specified `period` and were active for the given `date` bucket.
        public var rate: Double
        /// How many users registered in the specified `period` and were active for the given `date` bucket.
        public var value: Int
    }

    public enum BucketSize: String, Codable, Hashable {
        /// Daily buckets
        case day = "day"
        /// Monthly buckets
        case month = "month"
    }

    /// Represents a retention metric.
    public struct Cohort: Codable, Hashable {
        /// The timestamp for the start of the period, at midnight.
        public var period: String
        /// The size of the bucket for the returned data.
        public var frequency: BucketSize
        /// Retention data for users who registered during the given period.
        public var data: [CohortData]
    }
}
