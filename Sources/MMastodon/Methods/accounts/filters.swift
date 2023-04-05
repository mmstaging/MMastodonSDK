extension MastodonAPI.SessionContext {

    public func getAllFilters() -> MastodonAPI.Transaction<[MastodonAPI.Entities.Filter]> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v2/filters", requiresAuthToken: true, requiredScope: .read_filters)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func getFilter(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Filter> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v2/filters/\(id)", requiresAuthToken: true, requiredScope: .read_filters)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func createFilter(
                             title: String,
                             context: [String],
                             filter_action: MastodonAPI.Entities.Filter.Action? = nil,
                             expires_in: Int? = nil,
                             keywords_attributes: [MastodonAPI.Entities.FilterKeyword]? = nil

                             ) -> MastodonAPI.Transaction<MastodonAPI.Entities.Filter> {
        let queryParams = HTTPParams([
            "title": title,
            "filter_action": filter_action?.rawValue as Any,
            "expires_in": expires_in as Any
        ])

        for item in context {
            queryParams.add(param:"context[]", value:item)
        }

        if let keywords_attributes {
            for i in keywords_attributes.indices {
                queryParams.add(param:"keywords_attributes[][keyword]", value: keywords_attributes[i].keyword)
                queryParams.add(param:"keywords_attributes[][whole_word]", value: keywords_attributes[i].whole_word)
            }
        }

        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v2/filters", queryParams: queryParams, requiresAuthToken: true, requiredScope: .write_filters)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }


    public func updateFilter(
                             id: String,
                             title: String,
                             context: [String],
                             filter_action: MastodonAPI.Entities.Filter.Action? = nil,
                             expires_in: Int? = nil,
                             keywords_attributes: [MastodonAPI.Entities.FilterKeyword]? = nil

                             ) -> MastodonAPI.Transaction<MastodonAPI.Entities.Filter> {
        let queryParams = HTTPParams([
            "title": title,
            "filter_action": filter_action?.rawValue as Any,
            "expires_in": expires_in as Any
        ])

        for item in context {
            queryParams.add(param:"context[]", value:item)
        }

        if let keywords_attributes {
            for i in keywords_attributes.indices {
                queryParams.add(param:"keywords_attributes[][id]", value: keywords_attributes[i].id)
                queryParams.add(param:"keywords_attributes[][keyword]", value: keywords_attributes[i].keyword)
                queryParams.add(param:"keywords_attributes[][whole_word]", value: keywords_attributes[i].whole_word)
                if let destroy = keywords_attributes[i]._destroy, destroy {
                    queryParams.add(param:"keywords_attributes[][_destroy]", value: true)
                }
            }
        }

        let urlRequest = constructURLRequest(method: .PUT, uriTemplate: "/api/v2/filters/\(id)", queryParams: queryParams, requiresAuthToken: true, requiredScope: .write_filters)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func deleteFilter(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.EmptyObjectResponse> {
        let urlRequest = constructURLRequest(method: .DELETE, uriTemplate: "/api/v2/filters/\(id)", requiresAuthToken: true, requiredScope: .write_filters)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func getFiltersAddedKeywords(filter_id: String) -> MastodonAPI.Transaction<[MastodonAPI.Entities.FilterKeyword]> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v2/filters/\(filter_id)/keywords", requiresAuthToken: true, requiredScope: .read_filters)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func addKeywordToFilter(
                                    filter_id: String,
                                    keyword: String,
                                    whole_word: Bool
                                  ) -> MastodonAPI.Transaction<MastodonAPI.Entities.FilterKeyword> {
        let bodyParams = HTTPParams([
            "keyword": keyword,
            "whole_word": whole_word
        ])

        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v2/filters/\(filter_id)/keywords", requiresAuthToken: true, requiredScope: .write_filters, bodyString: bodyParams.asJSON)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func getSingleKeyword(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.FilterKeyword> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v2/filters/keywords/\(id)", requiresAuthToken: true, requiredScope: .read_filters)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func editFilterKeyword(
                                    id: String,
                                    keyword: String,
                                    whole_word: Bool? = nil
                                  ) -> MastodonAPI.Transaction<MastodonAPI.Entities.FilterKeyword> {
        let bodyParams = HTTPParams([
            "keyword": keyword,
            "whole_word": whole_word as Any
        ])

        let urlRequest = constructURLRequest(method: .PUT, uriTemplate: "/api/v2/filters/keywords/\(id)", requiresAuthToken: true, requiredScope: .write_filters, bodyString: bodyParams.asJSON)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func removeFilterKeywords(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.EmptyObjectResponse> {
        let urlRequest = constructURLRequest(method: .DELETE, uriTemplate: "/api/v2/filters/keywords/\(id)", requiresAuthToken: true, requiredScope: .write_filters)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func getAllStatusFilters(filter_id: String) -> MastodonAPI.Transaction<[MastodonAPI.Entities.FilterStatus]> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v2/filters/\(filter_id)/statuses", requiresAuthToken: true, requiredScope: .read_filters)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func addStatusToFilterGroup(filter_id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.FilterStatus> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v2/filters/\(filter_id)/statuses", requiresAuthToken: true, requiredScope: .write_filters)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func getSingleStatusFilter(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.FilterStatus> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v2/filters/statuses/\(id)", requiresAuthToken: true, requiredScope: .read_filters)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func deleteStatusFromFilterGroup(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.FilterStatus> {
        let urlRequest = constructURLRequest(method: .DELETE, uriTemplate: "/api/v2/filters/statuses/\(id)", requiresAuthToken: true, requiredScope: .write_filters)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }
}
