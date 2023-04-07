extension MastodonAPI.SessionContext {

    public func getLists() -> MastodonAPI.Transaction<[MastodonAPI.Entities.List]> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/lists", requiresAuthToken: true, requiredScope: .read_lists)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func getList(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.List> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/lists/\(id)", requiresAuthToken: true, requiredScope: .read_lists)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func createList(title: String, replies_policy: MastodonAPI.Entities.List.RepliesPolicy) -> MastodonAPI.Transaction<MastodonAPI.Entities.List> {
        let bodyParams = HTTPParams([
            "title": title,
            "replies_policy": replies_policy.rawValue
        ])
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/lists", requiresAuthToken: true, requiredScope: .write_lists, bodyString: bodyParams.asJSON)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func updateList(
                            id: String,
                            title: String,
                            replies_policy: MastodonAPI.Entities.List.RepliesPolicy? = nil
                          ) -> MastodonAPI.Transaction<MastodonAPI.Entities.List> {
        let bodyParams = HTTPParams([
            "title": title,
            "replies_policy": replies_policy?.rawValue as Any
        ])
        let urlRequest = constructURLRequest(method: .PUT, uriTemplate: "/api/v1/lists/\(id)", requiresAuthToken: true, requiredScope: .write_lists, bodyString: bodyParams.asJSON)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func deleteList(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.EmptyObjectResponse> {
        let urlRequest = constructURLRequest(method: .DELETE, uriTemplate: "/api/v1/lists/\(id)", requiresAuthToken: true, requiredScope: .write_lists)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func viewAccountsInList(
                                id: String,
                                limit: Int? = nil,
                                paginationLink: HTTPParams? = nil
                            ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Account]> {
        let queryParams = HTTPParams([
            "limit": limit as Any
        ])
        queryParams.add(params: paginationLink)

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/lists/\(id)/accounts", queryParams: queryParams, requiresAuthToken: true, requiredScope: .read_lists)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func addAccountToList(id: String, account_ids: [String]) -> MastodonAPI.Transaction<MastodonAPI.Entities.EmptyObjectResponse> {
        struct BodyParams: Encodable {
            let account_ids: [String]
        }

        let bodyParams = BodyParams(account_ids: account_ids)
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/lists/\(id)/accounts", requiresAuthToken: true, requiredScope: .write_lists, bodyEncodable: bodyParams)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func deleteAccountsFromList(id: String, account_ids: [String]) -> MastodonAPI.Transaction<MastodonAPI.Entities.EmptyObjectResponse> {
        struct BodyParams: Encodable {
            let account_ids: [String]
        }

        let bodyParams = BodyParams(account_ids: account_ids)
        let urlRequest = constructURLRequest(method: .DELETE, uriTemplate: "/api/v1/lists/\(id)/accounts", requiresAuthToken: true, requiredScope: .write_lists, bodyEncodable: bodyParams)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }
}
