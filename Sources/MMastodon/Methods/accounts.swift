import Foundation

extension MastodonAPI.SessionContext {

    public func registerAccount(
                                username: String,
                                email: String,
                                password: String,
                                agreement: Bool,
                                locale: String,
                                reason: String? = nil
                    ) -> MastodonAPI.Transaction<MastodonAPI.Entities.EmptyObjectResponse> {
        //TODO: Process errror responses
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/accounts", requiresAuthToken: true, requiredScope: .write_accounts)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func verifyCredentials() -> MastodonAPI.Transaction<MastodonAPI.Entities.Account> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/accounts/verify_credentials", requiresAuthToken: true, requiredScope: .read_accounts)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func updateAccountCredentials(
                                            display_name: String? = nil,
                                            note: String? = nil,
                                            avatar: MastodonAPI.HTTPFile? = nil,
                                            header: MastodonAPI.HTTPFile? = nil,
                                            locked: Bool? = nil,
                                            bot: Bool? = nil,
                                            discoverable: Bool? = nil,
                                            fields_attributes: [MastodonAPI.Entities.Field]? = nil,
                                            source: MastodonAPI.Entities.Account.Source? = nil

                                        ) -> MastodonAPI.Transaction<MastodonAPI.Entities.Account> {

        let bodyParams = HTTPParams([
            "display_name": display_name as Any,
            "note": note as Any,
            "locked": locked as Any,
            "bot": bot as Any,
            "discoverable": discoverable as Any
        ])

        if let avatar {
            bodyParams.add(param: "avatar", file: avatar)
        }

        if let header {
            bodyParams.add(param: "header", file: header)
        }

        if let source {
            bodyParams.add(param:"source[privacy]", value:source.privacy)
            bodyParams.add(param:"source[sensitive]", value:source.sensitive)
            bodyParams.add(param:"source[language]", value:source.language)
        }

        if let fields_attributes, !fields_attributes.isEmpty  {
            for i in fields_attributes.indices {
                bodyParams.add(param:"fields_attributes[\(i)][name]", value: fields_attributes[i].name)
                bodyParams.add(param:"fields_attributes[\(i)][value]", value: fields_attributes[i].value)
            }
        } else {
            bodyParams.add(param:"fields_attributes[]", value: "")
        }

        let urlRequest = constructURLRequest(method: .PATCH, uriTemplate: "/api/v1/accounts/update_credentials", requiresAuthToken: true, requiredScope: .write_accounts, bodyMultipartFormData: bodyParams.asMultipartFormData)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }


    public func getAccount(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Account> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/accounts/\(id)", requiresAuthToken: true)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }


    public func getAccountStatuses(
                                    id: String,
                                    publicStatusesOnly: Bool
                            ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Status]> {

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/accounts/\(id)/statuses", requiresAuthToken: publicStatusesOnly, requiredScope: !publicStatusesOnly ? .read_statuses : nil)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }


    public func getAccountFollowers(
                                    id: String,
                                    max_id: String? = nil,
                                    since_id: String? = nil,
                                    min_id: String? = nil,
                                    limit: Int? = nil
                                ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Account]> {
        let queryParams = HTTPParams([
            "max_id": max_id as Any,
            "since_id": since_id as Any,
            "min_id": min_id as Any,
            "limit": limit as Any
        ])

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/accounts/\(id)/followers", queryParams: queryParams, requiresAuthToken: true)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
        //TODO: Need to process prev/next weblinks on response headers
    }

    public func getAccountFollowing(
                                    id: String,
                                    max_id: String? = nil,
                                    since_id: String? = nil,
                                    min_id: String? = nil,
                                    limit: Int? = nil
                                ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Account]> {
        let queryParams = HTTPParams([
            "max_id": max_id as Any,
            "since_id": since_id as Any,
            "min_id": min_id as Any,
            "limit": limit as Any
        ])

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/accounts/\(id)/following", queryParams: queryParams, requiresAuthToken: true)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
        //TODO: Need to process prev/next weblinks on response headers
    }

    public func getAccountFeaturedTags(id: String) -> MastodonAPI.Transaction<[MastodonAPI.Entities.FeaturedTag]> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/accounts/\(id)/featured_tags", requiresAuthToken: true)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }


    public func getListsContainingThisAccount(id: String) -> MastodonAPI.Transaction<[MastodonAPI.Entities.List]> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/accounts/\(id)/lists", requiresAuthToken: true, requiredScope: .read_lists)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func followAccount(
                                id: String,
                                reblogs: Bool = true,
                                notify: Bool = false,
                                languages: [String]? = nil) -> MastodonAPI.Transaction<MastodonAPI.Entities.Relationship> {

        let bodyParams = HTTPParams([
            "reblogs": reblogs,
            "notify": notify,
            "languages": languages as Any
        ])

        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/accounts/\(id)/follow", requiresAuthToken: true, requiredScope: .write_follows, bodyString: bodyParams.asJSON)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func unfollowAccount(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Relationship> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/accounts/\(id)/unfollow", requiresAuthToken: true, requiredScope: .write_follows)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func removeAccountFromFollowers(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Relationship> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/accounts/\(id)/remove_from_followers", requiresAuthToken: true, requiredScope: .write_follows)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func blockAccount(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Relationship> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/accounts/\(id)/block", requiresAuthToken: true, requiredScope: .write_blocks)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func unblockAccount(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Relationship> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/accounts/\(id)/unblock", requiresAuthToken: true, requiredScope: .write_blocks)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func muteAccount(
                                id: String,
                                notifications: Bool = true,
                                duration: Int = 0
                            ) -> MastodonAPI.Transaction<MastodonAPI.Entities.Relationship> {

        let bodyParams = HTTPParams([
            "notifications": notifications,
            "duration": duration
        ])

        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/accounts/\(id)/mute", requiresAuthToken: true, requiredScope: .write_mutes, bodyString: bodyParams.asJSON)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func unmuteAccount(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Relationship> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/accounts/\(id)/unmute", requiresAuthToken: true, requiredScope: .write_mutes)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func featureAccountOnProfile(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Relationship> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/accounts/\(id)/pin", requiresAuthToken: true, requiredScope: .write_accounts)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func unfeatureAccountOnProfile(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Relationship> {
        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/accounts/\(id)/unpin", requiresAuthToken: true, requiredScope: .write_accounts)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func setPrivateNoteOnProfile(
                                        id: String,
                                        comment: String = ""
                                       ) -> MastodonAPI.Transaction<MastodonAPI.Entities.Relationship> {
        let bodyParams = HTTPParams([
            "comment": comment
        ])

        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v1/accounts/\(id)/note", requiresAuthToken: true, requiredScope: .write_accounts, bodyString: bodyParams.asJSON)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func checkRelationshipsToOtherAccounts(ids: [String]) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Relationship]> {
        let query = ids.map { "id[]=\($0)" }.joined(separator: "&")
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/accounts/relationships?\(query)", requiresAuthToken: true, requiredScope: .read_follows)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func findFamiliarFollowers(ids: [String]) -> MastodonAPI.Transaction<[MastodonAPI.Entities.FamiliarFollowers]> {
        let query = ids.map { "id[]=\($0)" }.joined(separator: "&")
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/accounts/familiar_followers?\(query)", requiresAuthToken: true, requiredScope: .read_follows)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }



    public func searchForMatchingAccounts (
                                            id: String,
                                            q: String,
                                            limit: Int? = nil,
                                            offset: Int? = nil,
                                            resolve: Bool? = nil,
                                            following: Bool? = nil
                                       ) -> MastodonAPI.Transaction<[MastodonAPI.Entities.Account]> {
        let queryParams = HTTPParams([
            "q": q,
            "limit": limit as Any,
            "offset": offset as Any,
            "resolve": resolve as Any,
            "following": following as Any
        ])

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/accounts/search", queryParams: queryParams, requiresAuthToken: true, requiredScope: .read_accounts)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }

    public func lookupAccountIDFromWebfingerAddress(acct: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.Account> {
        let queryParams = HTTPParams([
            "acct": acct
        ])

        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/accounts/lookup", queryParams: queryParams)
        return .init(urlSession: urlSession, urlRequest: urlRequest)
    }
}








