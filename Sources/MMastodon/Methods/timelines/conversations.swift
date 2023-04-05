extension MastodonAPI.SessionContext {

    public func getAllConversations(
                                max_id: String? = nil,
                                since_id: String? = nil,
                                min_id: String? = nil,
                                limit: Int? = nil
                            ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Conversation]> {
        let queryParams = HTTPParams([
            "max_id": max_id as Any,
            "since_id": since_id as Any,
            "min_id": min_id as Any,
            "limit": limit as Any
        ])

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/conversations", queryParams: queryParams, requiresAuthToken: true, requiredScope: .read_statuses)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func deleteConversation(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.EmptyObjectResponse> {
        let urlRequest = constructURLRequest(method: .DELETE, uriTemplate: "/api/v1/conversations/\(id)", requiresAuthToken: true, requiredScope: .write_conversations)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func markConversationAsRead(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Conversation> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/conversations/\(id)/read", requiresAuthToken: true, requiredScope: .write_conversations)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }
}
