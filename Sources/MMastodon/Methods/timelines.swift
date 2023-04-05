extension MastodonAPI.SessionContext {

    public func getPublicTimeline(
                                    local: Bool? = nil,
                                    remote: Bool? = nil,
                                    only_media: Bool? = nil,
                                    max_id: String? = nil,
                                    since_id: String? = nil,
                                    min_id: String? = nil,
                                    limit: Int? = nil
                                ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Status]> {
        let queryParams = HTTPParams([
            "local": local as Any,
            "remote": remote as Any,
            "only_media": only_media as Any,
            "max_id": max_id as Any,
            "since_id": since_id as Any,
            "min_id": min_id as Any,
            "limit": limit as Any
        ])

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/timelines/public", queryParams: queryParams, requiresAuthToken: true, requiredScope: .read_statuses)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
        //TODO: Need to process prev/next weblinks on response headers
    }

    public func getHashtagTimeline(
                                    hashtag: String,
                                    `any`: [String]? = nil,
                                    all: [String]? = nil,
                                    none: [String]? = nil,
                                    local: Bool? = nil,
                                    remote: Bool? = nil,
                                    only_media: Bool? = nil,
                                    max_id: String? = nil,
                                    since_id: String? = nil,
                                    min_id: String? = nil,
                                    limit: Int? = nil
                                ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Status]> {
        let queryParams = HTTPParams([
            "local": local as Any,
            "remote": remote as Any,
            "only_media": only_media as Any,
            "max_id": max_id as Any,
            "since_id": since_id as Any,
            "min_id": min_id as Any,
            "limit": limit as Any
        ])

        if let any {
            for item in any {
                queryParams.add(param: "any[]", value: item)
            }
        }

        if let all {
            for item in all {
                queryParams.add(param: "all[]", value: item)
            }
        }

        if let none {
            for item in none {
                queryParams.add(param: "none[]", value: item)
            }
        }

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/timelines/tag/\(hashtag)", queryParams: queryParams, requiresAuthToken: true, requiredScope: .read_statuses)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
        //TODO: Need to process prev/next weblinks on response headers
    }

    public func getHomeTimeline(
                                    max_id: String? = nil,
                                    since_id: String? = nil,
                                    min_id: String? = nil,
                                    limit: Int? = nil
                                ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Status]> {
        let queryParams = HTTPParams([
            "max_id": max_id as Any,
            "since_id": since_id as Any,
            "min_id": min_id as Any,
            "limit": limit as Any
        ])

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/timelines/home", queryParams: queryParams, requiresAuthToken: true, requiredScope: .read_statuses)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
        //TODO: Need to process prev/next weblinks on response headers
    }

    public func getListTimeline(
                                list_id: String,
                                max_id: String? = nil,
                                since_id: String? = nil,
                                min_id: String? = nil,
                                limit: Int? = nil
                            ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Status]> {
        let queryParams = HTTPParams([
            "max_id": max_id as Any,
            "since_id": since_id as Any,
            "min_id": min_id as Any,
            "limit": limit as Any
        ])

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/timelines/list/\(list_id)", queryParams: queryParams, requiresAuthToken: true, requiredScope: .read_lists)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }
}
