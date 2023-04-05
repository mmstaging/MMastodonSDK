extension MastodonAPI.SessionContext {

    public func getSavedTimelinePositions(id: String, timeline: [String]) -> MastodonAPI.Transaction<[String: MastodonAPI.Entities.Marker]> {
        struct BodyParams: Encodable {
            let timeline: [String]
        }

        let bodyParams = BodyParams(timeline: timeline)
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/markers", requiresAuthToken: true, requiredScope: .read_statuses, bodyEncodable: bodyParams)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
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
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }
}
