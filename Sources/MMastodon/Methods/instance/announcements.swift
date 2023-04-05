extension MastodonAPI.SessionContext {

    public func getAllAnnouncements(with_dismissed:Bool? = nil) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Announcement]> {
        let queryParams = HTTPParams([
            "with_dismissed": with_dismissed as Any
        ])
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/announcements", queryParams: queryParams, requiresAuthToken: true)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func dismissAnnouncement(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.EmptyObjectResponse> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/announcements/\(id)/dismiss", requiresAuthToken: true, requiredScope: .write_accounts)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func addReactionToAnnouncement(id:String, name:String) -> MastodonAPI.Transaction<MastodonAPI.Entities.EmptyObjectResponse> {
        let urlRequest = constructURLRequest(method: .PUT, uriTemplate: "/api/v1/announcements/\(id)/reactions/\(name)", requiresAuthToken: true, requiredScope: .write_favourites)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func deleteReactionToAnnouncement(id:String, name:String) -> MastodonAPI.Transaction<MastodonAPI.Entities.EmptyObjectResponse> {
        let urlRequest = constructURLRequest(method: .DELETE, uriTemplate: "/api/v1/announcements/\(id)/reactions/\(name)", requiresAuthToken: true, requiredScope: .write_favourites)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }
}
