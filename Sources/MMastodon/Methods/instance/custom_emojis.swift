extension MastodonAPI.SessionContext {

    public func getAllCustomEmoji() -> MastodonAPI.Transaction<[MastodonAPI.Entities.CustomEmoji]> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/custom_emojis")
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }
}
