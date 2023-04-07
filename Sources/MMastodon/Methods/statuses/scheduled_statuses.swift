extension MastodonAPI.SessionContext {

    public func getScheduledStatuses(
                                    limit: Int? = nil,
                                    paginationLink: HTTPParams? = nil
                                ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.ScheduledStatus]> {
        let queryParams = HTTPParams([
            "limit": limit as Any
        ])
        queryParams.add(params: paginationLink)

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/scheduled_statuses", queryParams: queryParams, requiresAuthToken: true, requiredScope: .read_statuses)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func getSingleScheduledStatus(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.ScheduledStatus> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/scheduled_statuses/\(id)", requiresAuthToken: true, requiredScope: .read_statuses)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func updateScheduledStatusDate(id: String, scheduled_at: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.ScheduledStatus> {
        let bodyParams = HTTPParams([
            "scheduled_at": scheduled_at
        ])

        let urlRequest = constructURLRequest(method: .PUT, uriTemplate: "/api/v1/scheduled_statuses/\(id)", requiresAuthToken: true, requiredScope: .write_statuses, bodyString: bodyParams.asJSON)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func cancelScheduledStatus(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.EmptyObjectResponse> {
        let urlRequest = constructURLRequest(method: .DELETE, uriTemplate: "/api/v1/scheduled_statuses/\(id)", requiresAuthToken: true, requiredScope: .write_statuses)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

}
