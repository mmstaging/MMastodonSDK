import Foundation

extension MastodonAPI.SessionContext {

    public func getTrendingTags(
                                     offset:Int? = nil,
                                     limit:Int? = nil
                                    ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Tag]> {
        let queryParams = HTTPParams([
            "offset": offset as Any,
            "limit": limit as Any
        ])

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/trends/tags", queryParams: queryParams)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func getTrendingStatuses(
                                     offset:Int? = nil,
                                     limit:Int? = nil
                                    ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Status]> {
        let queryParams = HTTPParams([
            "offset": offset as Any,
            "limit": limit as Any
        ])

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/trends/statuses", queryParams: queryParams)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func getTrendingLinks(
                                     offset:Int? = nil,
                                     limit:Int? = nil
                                    ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.PreviewCard]> {
        let queryParams = HTTPParams([
            "offset": offset as Any,
            "limit": limit as Any
        ])

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/trends/links", queryParams: queryParams)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }
}
