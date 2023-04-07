extension MastodonAPI.SessionContext {

    public func getAllConversations(
                                    limit: Int? = nil,
                                    paginationLink: HTTPParams? = nil
                            ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Conversation]> {
        let queryParams = HTTPParams([
            "limit": limit as Any
        ])
        queryParams.add(params: paginationLink)

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/conversations", queryParams: queryParams, requiresAuthToken: true, requiredScope: .read_statuses)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func deleteConversation(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.EmptyObjectResponse> {
        let urlRequest = constructURLRequest(method: .DELETE, uriTemplate: "/api/v1/conversations/\(id)", requiresAuthToken: true, requiredScope: .write_conversations)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func markConversationAsRead(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Conversation> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/conversations/\(id)/read", requiresAuthToken: true, requiredScope: .write_conversations)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }
}
