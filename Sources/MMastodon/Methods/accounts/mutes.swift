extension MastodonAPI.SessionContext {

    public func getMutedAccounts(
                                    limit: Int? = nil,
                                    paginationLink: HTTPParams? = nil
                                ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Account]> {
        let queryParams = HTTPParams([
            "limit": limit as Any
        ])
        queryParams.add(params: paginationLink)

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/mutes", queryParams: queryParams, requiresAuthToken: true, requiredScope: .read_mutes)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }
}
