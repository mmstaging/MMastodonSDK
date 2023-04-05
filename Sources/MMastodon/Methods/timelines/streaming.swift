extension MastodonAPI.SessionContext {

    public func getStreamingServiceHealth() -> MastodonAPI.Transaction<String> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/streaming/health")
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }


    //TODO: Streaming APIs. Requires WebSocket mechanism.
    //	- Watch your home timeline and notifications
    //	- Watch your notifications
    //	- Watch the federated timeline
    //	- Watch the local timeline
    //	- Watch for remote statuses
    //	- Watch the public timeline for a hashtag
    //	- Watch the local timeline for a hashtag
    //	- Watch for list updates
    //	- Watch for direct messages
}
