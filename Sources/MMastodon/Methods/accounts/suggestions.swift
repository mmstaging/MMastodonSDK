extension MastodonAPI.SessionContext {

    public func getSuggestedFollows(limit: Int? = nil) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Suggestion]> {
        let queryParams = HTTPParams([
            "limit": limit as Any
        ])
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v2/suggestions", queryParams: queryParams, requiresAuthToken: true, requiredScope: .read)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func removeSuggestedFollow(account_id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.EmptyObjectResponse> {
        let urlRequest = constructURLRequest(method: .DELETE, uriTemplate: "/api/v1/suggestions/\(account_id)", requiresAuthToken: true, requiredScope: .read)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }
}
