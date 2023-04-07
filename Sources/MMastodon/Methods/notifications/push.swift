extension MastodonAPI.SessionContext {


    fileprivate struct BodyData: Encodable {
        let alerts: MastodonAPI.Entities.WebPushSubscription.AlertSubscription
        let policy: String
    }

    fileprivate struct BodySubscriptionKeys: Encodable {
        let p256dh: String
        let auth: String
    }

    fileprivate struct BodySubscription: Encodable {
        let keys: BodySubscriptionKeys
        let endpoint: String
    }


    public func pushSubscribe(
                                endpoint: String,
                                keys_p256dh: String,
                                keys_auth: String,
                                alerts: MastodonAPI.Entities.WebPushSubscription.AlertSubscription,
                                policy: String
                            ) -> MastodonAPI.Transaction<MastodonAPI.Entities.WebPushSubscription> {
        struct BodyParams: Encodable {
            let data: BodyData
            let subscription: BodySubscription
        }

        let bodyParams = BodyParams(data: BodyData(alerts: alerts, policy:policy), subscription: BodySubscription(keys: BodySubscriptionKeys(p256dh: keys_p256dh, auth: keys_auth), endpoint: endpoint))
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/push/subscription", requiresAuthToken: true, requiredScope: .push, bodyEncodable: bodyParams)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func getPushSubscription() -> MastodonAPI.Transaction<MastodonAPI.Entities.WebPushSubscription> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/push/subscription", requiresAuthToken: true, requiredScope: .push)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func changePushSubscription(
                                        alerts: MastodonAPI.Entities.WebPushSubscription.AlertSubscription,
                                        policy: String
                                    ) -> MastodonAPI.Transaction<MastodonAPI.Entities.WebPushSubscription> {
        struct BodyParams: Encodable {
            let data: BodyData
        }

        let bodyParams = BodyParams(data: BodyData(alerts: alerts, policy:policy))
        let urlRequest = constructURLRequest(method: .PUT, uriTemplate: "/api/v1/push/subscription", requiresAuthToken: true, requiredScope: .push, bodyEncodable: bodyParams)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func deletePushSubscription() -> MastodonAPI.Transaction<MastodonAPI.Entities.EmptyObjectResponse> {
        let urlRequest = constructURLRequest(method: .DELETE, uriTemplate: "/api/v1/push/subscription", requiresAuthToken: true, requiredScope: .push)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }
}
