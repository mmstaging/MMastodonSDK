extension MastodonAPI.SessionContext {

    public func getFavouritedStatuses(
                                    limit: Int? = nil,
                                    paginationLink: HTTPParams? = nil
                                ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Status]> {
        let queryParams = HTTPParams([
            "limit": limit as Any
        ])
        queryParams.add(params: paginationLink)

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/favourites", queryParams: queryParams, requiresAuthToken: true, requiredScope: .read_favourites)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }
}
