extension MastodonAPI.SessionContext {

    public func resendConfirmationEmail(email: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.EmptyObjectResponse> {

        let bodyParams = HTTPParams([
            "email": email
        ])

        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/emails/confirmation", requiresAuthToken: true, bodyString: bodyParams.asJSON)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }
}
