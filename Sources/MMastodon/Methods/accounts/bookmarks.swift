extension MastodonAPI.SessionContext {

    public func getBookmarkedStatuses(
                                    limit: Int? = nil,
                                    paginationLink: HTTPParams? = nil
                                ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Status]> {
        let queryParams = HTTPParams([
            "limit": limit as Any
        ])
        queryParams.add(params: paginationLink)

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/bookmarks", queryParams: queryParams, requiresAuthToken: true, requiredScope: .read_bookmarks)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }
}

