extension MastodonAPI.SessionContext {

    public enum TokenGrantType:String {
        /// Request authorization to a specific user account
        case authorization_code
        /// Request non-user-account authorization to access the instance
        case client_credentials
    }

    /// This function is unusual, returning a String instead of a Transaction object.
    public func authorizeUser(
                                response_type: String = "code",
                                client_id: String,
                                redirect_uri: String,
                                scope: OAuthScope,
                                force_login: Bool = false,
                                lang: String = "en"
                            )  -> String {
        let template = "/oauth/authorize"
        let queryParams = HTTPParams([
            "response_type": response_type,
            "client_id": client_id,
            "redirect_uri": redirect_uri,
            "scope": scope.asString,
            "force_login": force_login,
            "lang": lang
        ])

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: template, queryParams: queryParams)
        return "\(urlRequest)"
    }

    public func obtainToken(
                            grant_type: TokenGrantType,
                            code: String? = nil,
                            client_id: String,
                            client_secret: String,
                            redirect_uri: String,
                            scope: OAuthScope
                        ) -> MastodonAPI.Transaction<MastodonAPI.Entities.Token> {

        let bodyParams = HTTPParams([
            "grant_type": grant_type.rawValue,
            "code": code as Any,
            "client_id": client_id,
            "client_secret": client_secret,
            "redirect_uri": redirect_uri,
            "scope": scope.asString
        ])

        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/oauth/token", bodyString: bodyParams.asJSON)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func revokeToken(
                            client_id: String,
                            client_secret: String,
                            token: String
                            ) -> MastodonAPI.Transaction<MastodonAPI.Entities.EmptyObjectResponse> {
        let bodyParams = HTTPParams([
            "client_id": client_id,
            "client_secret": client_secret,
            "token": token
        ])
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/oauth/revoke", bodyString: bodyParams.asJSON)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }
}

