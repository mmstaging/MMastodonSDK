extension MastodonAPI.SessionContext {

    public func getPoll(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Poll> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/polls/\(id)", requiresAuthToken: true, requiredScope: .read_statuses)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func votePoll(id: String, choices:[Int]) -> MastodonAPI.Transaction<MastodonAPI.Entities.Poll> {
        struct BodyParams: Encodable {
            let choices: [Int]
        }
        let bodyParams = BodyParams(choices: choices)
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/polls/\(id)/votes", requiresAuthToken: true, requiredScope: .write_statuses, bodyEncodable: bodyParams)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }
}
