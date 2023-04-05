extension MastodonAPI.SessionContext {


    public func getPendingFollowRequests(
                                    max_id: String? = nil,
                                    since_id: String? = nil,
                                    limit: Int? = nil
                                ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Account]> {
        let queryParams = HTTPParams([
            "max_id": max_id as Any,
            "since_id": since_id as Any,
            "limit": limit as Any
        ])

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/follow_requests", queryParams: queryParams, requiresAuthToken: true, requiredScope: .read_follows)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
        //TODO: Need to process prev/next weblinks on response headers
    }

    public func acceptFollowRequest(account_id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Relationship> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/follow_requests/\(account_id)/authorize", requiresAuthToken: true, requiredScope: .write_follows)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func rejectFollowRequest(account_id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Relationship> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/follow_requests/\(account_id)/reject", requiresAuthToken: true, requiredScope: .write_follows)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }
}
