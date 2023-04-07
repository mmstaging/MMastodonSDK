extension MastodonAPI.SessionContext {

    public func getSavedTimelinePositions(id: String, timeline: [String]) -> MastodonAPI.Transaction<[String: MastodonAPI.Entities.Marker]> {
        let queryParams = timeline.reduce(into: HTTPParams()) { params, location in
            params.add(param: "timeline[]", value: location)
        }

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/markers", queryParams: queryParams, requiresAuthToken: true, requiredScope: .read_statuses)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }


    public func savePositionInTimeline(
                                        homeLastReadID: String? = nil,
                                        notificationsLastReadID: String? = nil
                                      ) -> MastodonAPI.Transaction<MastodonAPI.Entities.Marker> {
        let bodyParams = HTTPParams()
        if let homeLastReadID {
            bodyParams.add(param: "home[last_read_id]", value: homeLastReadID)
        }
        if let notificationsLastReadID {
            bodyParams.add(param: "notifications[last_read_id]", value: notificationsLastReadID)
        }
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/markers", requiresAuthToken: true, requiredScope: .write_statuses, bodyString: bodyParams.asJSON)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }
}
