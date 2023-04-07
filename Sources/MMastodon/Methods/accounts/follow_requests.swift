extension MastodonAPI.SessionContext {


    public func getPendingFollowRequests(
                                    limit: Int? = nil,
                                    paginationLink: HTTPParams? = nil
                                ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Account]> {
        let queryParams = HTTPParams([
            "limit": limit as Any
        ])
        queryParams.add(params: paginationLink)

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/follow_requests", queryParams: queryParams, requiresAuthToken: true, requiredScope: .read_follows)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func acceptFollowRequest(account_id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Relationship> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/follow_requests/\(account_id)/authorize", requiresAuthToken: true, requiredScope: .write_follows)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func rejectFollowRequest(account_id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Relationship> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/follow_requests/\(account_id)/reject", requiresAuthToken: true, requiredScope: .write_follows)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }
}
