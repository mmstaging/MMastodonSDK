extension MastodonAPI.SessionContext {

    public func getFeaturedTags() -> MastodonAPI.Transaction<[MastodonAPI.Entities.FeaturedTag]> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/featured_tags", requiresAuthToken: true, requiredScope: .read_accounts)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func featureTag(name: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.FeaturedTag> {
        let bodyParams = HTTPParams([
            "name": name
        ])

        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/featured_tags", requiresAuthToken: true, requiredScope: .write_accounts, bodyString: bodyParams.asJSON)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func unfeatureTag(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.EmptyObjectResponse> {
        let urlRequest = constructURLRequest(method: .DELETE, uriTemplate: "/api/v1/featured_tags/\(id)", requiresAuthToken: true, requiredScope: .write_accounts)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func getSuggestedFeatureTags() -> MastodonAPI.Transaction<[MastodonAPI.Entities.Tag]> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/featured_tags/suggestions", requiresAuthToken: true, requiredScope: .read_accounts)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }
}
