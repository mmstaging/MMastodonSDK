extension MastodonAPI.SessionContext {

    public func getScheduledStatuses(
                                    max_id: String? = nil,
                                    since_id: String? = nil,
                                    min_id: String? = nil,
                                    limit: Int? = nil
                                ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.ScheduledStatus]> {
        let queryParams = HTTPParams([
            "max_id": max_id as Any,
            "since_id": since_id as Any,
            "min_id": min_id as Any,
            "limit": limit as Any
        ])

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/scheduled_statuses", queryParams: queryParams, requiresAuthToken: true, requiredScope: .read_statuses)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
        //TODO: Need to process prev/next weblinks on response headers
    }

    public func getSingleScheduledStatus(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.ScheduledStatus> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/scheduled_statuses/\(id)", requiresAuthToken: true, requiredScope: .read_statuses)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func updateScheduledStatusDate(id: String, scheduled_at: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.ScheduledStatus> {
        let bodyParams = HTTPParams([
            "scheduled_at": scheduled_at
        ])

        let urlRequest = constructURLRequest(method: .PUT, uriTemplate: "/api/v1/scheduled_statuses/\(id)", requiresAuthToken: true, requiredScope: .write_statuses, bodyString: bodyParams.asJSON)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func cancelScheduledStatus(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.EmptyObjectResponse> {
        let urlRequest = constructURLRequest(method: .DELETE, uriTemplate: "/api/v1/scheduled_statuses/\(id)", requiresAuthToken: true, requiredScope: .write_statuses)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

}
