extension MastodonAPI.SessionContext {

    public func getTagInfo(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Tag> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/tags/\(id)", requiresAuthToken: true)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func followTag(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Tag> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/tags/\(id)/follow", requiresAuthToken: true, requiredScope: .write_follows)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func unfollowTag(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Tag> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/tags/\(id)/unfollow", requiresAuthToken: true, requiredScope: .write_follows)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }
}
