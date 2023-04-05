extension MastodonAPI.SessionContext {

    public func getUserPreferences() -> MastodonAPI.Transaction<MastodonAPI.Entities.Preferences> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/preferences", requiresAuthToken: true, requiredScope: .read_accounts)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }
}
