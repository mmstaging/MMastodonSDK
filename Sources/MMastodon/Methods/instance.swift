extension MastodonAPI.SessionContext {

    public func getInstance() -> MastodonAPI.Transaction<MastodonAPI.Entities.Instance> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v2/instance")
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func getPeerInstances() -> MastodonAPI.Transaction<[String]> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/instance/peers")
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func getWeeklyActivity() -> MastodonAPI.Transaction<[MastodonAPI.Entities.ActivityReport]> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/instance/activity")
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func getRules() -> MastodonAPI.Transaction<[MastodonAPI.Entities.Rule]> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/instance/rules")
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func getBlockedServers() -> MastodonAPI.Transaction<[MastodonAPI.Entities.DomainBlock]> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/instance/domain_blocks")
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func getExtendedDescription() -> MastodonAPI.Transaction<MastodonAPI.Entities.ExtendedDescription> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/instance/extended_description")
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }
}
