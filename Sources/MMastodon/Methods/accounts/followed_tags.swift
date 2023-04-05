extension MastodonAPI.SessionContext {

   public func getAllFollowedTags(
                                    max_id: String? = nil,
                                    since_id: String? = nil,
                                    min_id: String? = nil,
                                    limit: Int? = nil
                                ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Tag]> {
        let queryParams = HTTPParams([
            "max_id": max_id as Any,
            "since_id": since_id as Any,
            "min_id": max_id as Any,
            "limit": limit as Any
        ])

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/followed_tags", queryParams: queryParams, requiresAuthToken: true, requiredScope: .read_follows)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
        //TODO: Need to process prev/next weblinks on response headers
    }
}
