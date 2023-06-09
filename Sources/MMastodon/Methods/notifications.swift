extension MastodonAPI.SessionContext {

    /// This API returns Link headers containing links to the next/previous page. However, the links can also be constructed dynamically using query params and id values.
    public func getAllNotifications(
                                    limit: Int? = nil,
                                    paginationLink: HTTPParams? = nil,
                                    types: [MastodonAPI.Entities.NotificationType]? = nil,
                                    exclude_types: [MastodonAPI.Entities.NotificationType]? = nil,
                                    account_id: String? = nil
                ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Notification]> {
        let queryParams = HTTPParams([
            "limit": limit as Any,
            "account_id": account_id as Any
        ])
        queryParams.add(params: paginationLink)

        if let types {
            for item in types {
                queryParams.add(param: "types[]", value: item)
            }
        }

        if let exclude_types {
            for item in exclude_types {
                queryParams.add(param: "exclude_types[]", value: item)
            }
        }

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/notifications", queryParams: queryParams, requiresAuthToken: true, requiredScope: .read_notifications)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }


    public func getSingleNotification(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Notification> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/notifications/\(id)", requiresAuthToken: true, requiredScope: .read_notifications)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func dismissAllNotifications() -> MastodonAPI.Transaction<MastodonAPI.Entities.EmptyObjectResponse> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/notifications/clear", requiresAuthToken: true, requiredScope: .write_notifications)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func dismissSingleNotification(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.EmptyObjectResponse> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/notifications/\(id)/dismiss", requiresAuthToken: true, requiredScope: .write_notifications)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }
}


