extension MastodonAPI.SessionContext {

    public func getDomainBlocks(
                                    max_id: String? = nil,
                                    since_id: String? = nil,
                                    min_id: String? = nil,
                                    limit: Int? = nil
                                ) -> MastodonAPI.Transaction<[String]> {
        let queryParams = HTTPParams([
            "max_id": max_id as Any,
            "since_id": since_id as Any,
            "min_id": min_id as Any,
            "limit": limit as Any
        ])

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/domain_blocks", queryParams: queryParams, requiresAuthToken: true, requiredScope: .read_blocks)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
        //TODO: Need to process prev/next weblinks on response headers
    }


    public func blockDomain(domain: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.EmptyObjectResponse> {
        let bodyParams = HTTPParams([
            "domain": domain
        ])

        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/domain_blocks", requiresAuthToken: true, requiredScope: .write_blocks, bodyString: bodyParams.asJSON)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func unblockDomain(domain: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.EmptyObjectResponse> {
        let bodyParams = HTTPParams([
            "domain": domain
        ])

        let urlRequest = constructURLRequest(method: .DELETE, uriTemplate: "/api/v1/domain_blocks", requiresAuthToken: true, requiredScope: .write_blocks, bodyString: bodyParams.asJSON)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }
}
