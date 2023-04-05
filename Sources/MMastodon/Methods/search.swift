extension MastodonAPI.SessionContext {

    public enum SearchType: String {
        case accounts, hashtags, statuses
    }

    public func performSearch(
                                    q: String,
                                    type: SearchType? = nil,
                                    resolve: Bool? = nil,
                                    account_id: String? = nil,
                                    exclude_unreviewed: Bool? = nil,
                                    max_id: String? = nil,
                                    min_id: String? = nil,
                                    limit: Int? = nil,
                                    offset: String? = nil
                                ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Search]> {
        let queryParams = HTTPParams([
            "q": q,
            "type": type?.rawValue as Any,
            "resolve": resolve as Any,
            "account_id": account_id as Any,
            "exclude_unreviewed": exclude_unreviewed as Any,
            "max_id": max_id as Any,
            "min_id": min_id as Any,
            "limit": limit as Any,
            "offset": offset as Any
        ])

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v2/search", queryParams: queryParams, requiresAuthToken: true, requiredScope: .read_search)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }
}
