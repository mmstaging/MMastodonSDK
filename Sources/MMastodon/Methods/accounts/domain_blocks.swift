extension MastodonAPI.SessionContext {

    public func getDomainBlocks(
                                    limit: Int? = nil,
                                    paginationLink: HTTPParams? = nil
                                ) -> MastodonAPI.Transaction<[String]> {
        let queryParams = HTTPParams([
            "limit": limit as Any
        ])
        queryParams.add(params: paginationLink)

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/domain_blocks", queryParams: queryParams, requiresAuthToken: true, requiredScope: .read_blocks)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
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
