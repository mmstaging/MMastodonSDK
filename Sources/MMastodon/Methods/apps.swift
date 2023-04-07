extension MastodonAPI.SessionContext {


    public func createApplication(redirect_uris: String, website: String, client_name: String, scopes: OAuthScope = [.read]) -> MastodonAPI.Transaction<MastodonAPI.Entities.Application> {

        struct AppConfig: Codable, Hashable {
            let redirect_uris: String
            let website: String
            let client_name: String
            let scopes: String
        }

        let config = AppConfig(redirect_uris: redirect_uris, website: website, client_name: client_name, scopes: scopes.asString)
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/apps", bodyEncodable:config)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    // verifyCredentials -> dup of account.swift:verifyCredentials
}
