import Foundation

extension MastodonAPI.SessionContext {

    public func postNewStatus(
                                status: String? = nil,
                                media_ids: [String]? = nil,
                                poll:MastodonAPI.Entities.Poll? = nil,
                                in_reply_to_id: String? = nil,
                                sensitive: Bool = false,
                                spoiler_text: String? = nil,
                                visibility: MastodonAPI.Entities.PostVisibility? = nil,
                                language: String? = nil
                        ) -> MastodonAPI.Transaction<MastodonAPI.Entities.Status> {

        let headers = ["Idempotency-Key": UUID().uuidString]

        struct BodyParams: Encodable {
            let status: String?
            let media_ids: [String]?
            let poll:MastodonAPI.Entities.Poll?
            let in_reply_to_id: String?
            let sensitive: Bool
            let spoiler_text: String?
            let visibility: MastodonAPI.Entities.PostVisibility?
            let language: String?
        }

        let bodyParams = BodyParams(status: status, media_ids: media_ids, poll: poll, in_reply_to_id: in_reply_to_id, sensitive: sensitive, spoiler_text: spoiler_text, visibility: visibility, language: language)
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/statuses", headers: headers, requiresAuthToken: true, requiredScope: .write_statuses, bodyEncodable: bodyParams)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func scheduleNewStatus(
                                status: String? = nil,
                                media_ids: [String]? = nil,
                                poll:MastodonAPI.Entities.Poll? = nil,
                                in_reply_to_id: String? = nil,
                                sensitive: Bool = false,
                                spoiler_text: String? = nil,
                                visibility: MastodonAPI.Entities.PostVisibility? = nil,
                                language: String? = nil,
                                scheduled_at: String
                        ) -> MastodonAPI.Transaction<MastodonAPI.Entities.ScheduledStatus> {

        let headers = ["Idempotency-Key": UUID().uuidString]

        struct BodyParams: Encodable {
            let status: String?
            let media_ids: [String]?
            let poll:MastodonAPI.Entities.Poll?
            let in_reply_to_id: String?
            let sensitive: Bool
            let spoiler_text: String?
            let visibility: MastodonAPI.Entities.PostVisibility?
            let language: String?
            let scheduled_at: String
        }

        let bodyParams = BodyParams(status: status, media_ids: media_ids, poll: poll, in_reply_to_id: in_reply_to_id, sensitive: sensitive, spoiler_text: spoiler_text, visibility: visibility, language: language, scheduled_at: scheduled_at)
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/statuses", headers: headers, requiresAuthToken: true, requiredScope: .write_statuses, bodyEncodable: bodyParams)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func getStatus(id: String, isPublic: Bool) -> MastodonAPI.Transaction<MastodonAPI.Entities.Status> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/statuses/\(id)", requiresAuthToken: !isPublic, requiredScope: .read_statuses)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    /*

    Note the special properties text and poll or media_attachments which may be used to repost the status, e.g. in case of delete-and-redraft functionality. With POST /api/v1/statuses, use text as the value for status parameter, media_attachments[n]["id"] for the media_ids array parameter, and poll properties with the corresponding parameters (e.g. poll[multiple] and poll[options], with a new poll[expires_in] and poll[hide_totals] per user input.
    */
    public func deleteStatus(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Status> {
        let urlRequest = constructURLRequest(method: .DELETE, uriTemplate: "/api/v1/statuses/\(id)", requiresAuthToken: true, requiredScope: .write_statuses)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func getParentAndChildStatuses(id: String, isPublic: Bool) -> MastodonAPI.Transaction<MastodonAPI.Entities.Context> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/statuses/\(id)/context", requiresAuthToken: !isPublic, requiredScope: .read_statuses)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func translateStatus(id: String, lang:String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Translation> {
        let bodyParams = HTTPParams([
            "lang": lang
        ])
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/statuses/\(id)/translate", requiresAuthToken: true, requiredScope: .read_statuses, bodyString: bodyParams.asJSON)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func getStatusBoosters(
                                    id: String,
                                    limit: Int? = nil,
                                    paginationLink: HTTPParams? = nil
                                ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Account]> {
        let queryParams = HTTPParams([
            "limit": limit as Any
        ])
        queryParams.add(params: paginationLink)

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/statuses/\(id)/reblogged_by", queryParams: queryParams, requiresAuthToken: true, requiredScope: .read_statuses)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func getStatusFavouriters(
                                        id: String,
                                        limit: Int? = nil,
                                        paginationLink: HTTPParams? = nil
                                    ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Account]> {
        let queryParams = HTTPParams([
            "limit": limit as Any
        ])
        queryParams.add(params: paginationLink)

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/statuses/\(id)/favourited_by", queryParams: queryParams, requiresAuthToken: true, requiredScope: .read_statuses)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func favouriteStatus(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Status> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/statuses/\(id)/favourite", requiresAuthToken: true, requiredScope: .write_favourites)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func unfavouriteStatus(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Status> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/statuses/\(id)/unfavourite", requiresAuthToken: true, requiredScope: .write_favourites)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func boostStatus(id: String, visibility:MastodonAPI.Entities.PostVisibility) -> MastodonAPI.Transaction<MastodonAPI.Entities.Status> {
        let bodyParams = HTTPParams([
            "visibility": visibility.rawValue
        ])

        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/statuses/\(id)/reblog", requiresAuthToken: true, requiredScope: .write_statuses, bodyString: bodyParams.asJSON)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func unboostStatus(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Status> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/statuses/\(id)/unreblog", requiresAuthToken: true, requiredScope: .write_statuses)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func bookmarkStatus(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Status> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/statuses/\(id)/bookmark", requiresAuthToken: true, requiredScope: .write_bookmarks)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func unbookmarkStatus(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Status> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/statuses/\(id)/unbookmark", requiresAuthToken: true, requiredScope: .write_bookmarks)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func muteConversation(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Status> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/statuses/\(id)/mute", requiresAuthToken: true, requiredScope: .write_mutes)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func unmuteConversation(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Status> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/statuses/\(id)/unmute", requiresAuthToken: true, requiredScope: .write_mutes)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func pinStatusToProfile(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Status> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/statuses/\(id)/pin", requiresAuthToken: true, requiredScope: .write_accounts)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func unpinStatusFromProfile(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Status> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/statuses/\(id)/unpin", requiresAuthToken: true, requiredScope: .write_accounts)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func editStatus(
                                id: String,
                                status: String? = nil,
                                media_ids: [String]? = nil,
                                poll:MastodonAPI.Entities.Poll? = nil,
                                sensitive: Bool = false,
                                spoiler_text: String? = nil,
                                language: String? = nil
                        ) -> MastodonAPI.Transaction<MastodonAPI.Entities.Status> {

        struct BodyParams: Encodable {
            let status: String?
            let media_ids: [String]?
            let poll:MastodonAPI.Entities.Poll?
            let sensitive: Bool
            let spoiler_text: String?
            let language: String?
        }

        let bodyParams = BodyParams(status: status, media_ids: media_ids, poll: poll, sensitive: sensitive, spoiler_text: spoiler_text, language: language)

        let urlRequest = constructURLRequest(method: .PUT, uriTemplate: "/api/v1/statuses/\(id)", requiresAuthToken: true, requiredScope: .write_statuses, bodyEncodable: bodyParams)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func getStatusEditHistory(id: String) -> MastodonAPI.Transaction<[MastodonAPI.Entities.StatusEdit]> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/statuses/\(id)/history", requiresAuthToken: true, requiredScope: .read_statuses)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func getStatusSource(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.StatusSource> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/statuses/\(id)/source", requiresAuthToken: true, requiredScope: .read_statuses)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }
}
