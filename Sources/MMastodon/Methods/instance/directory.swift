extension MastodonAPI.SessionContext {

    public enum ProfileDirectoryOrder: String {
        case active, new
    }

    public func getProfileDirectory(
                                    offset:Int? = nil,
                                    limit:Int? = nil,
                                    order:ProfileDirectoryOrder? = nil,
                                    local:Bool? = nil
                                    ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Account]> {
        let queryParams = HTTPParams([
            "offset": offset as Any,
            "limit": limit as Any,
            "order": order?.rawValue as Any,
            "local": local as Any
        ])

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/directory", queryParams: queryParams)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }
}
