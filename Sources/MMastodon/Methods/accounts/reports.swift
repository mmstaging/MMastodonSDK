extension MastodonAPI.SessionContext {

    public func fileReport(
                            account_id: String,
                            status_ids: [String]? = nil,
                            comment: String? = nil,
                            forward: Bool? = nil,
                            category: String? = nil,
                            rule_ids: [Int]? = nil
                          ) -> MastodonAPI.Transaction<MastodonAPI.Entities.Report> {

        struct BodyParams: Encodable {
            let account_id: String
            let status_ids: [String]?
            let comment: String?
            let forward: Bool?
            let category: String?
            let rule_ids: [Int]?
        }

        let bodyParams = BodyParams(account_id: account_id, status_ids: status_ids, comment: comment, forward: forward, category: category, rule_ids: rule_ids)
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/reports", requiresAuthToken: true, requiredScope: .read_filters, bodyEncodable: bodyParams)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }
}
