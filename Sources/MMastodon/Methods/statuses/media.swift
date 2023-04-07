extension MastodonAPI.SessionContext {

    public func uploadMediaAttachment(
                                        file: HTTPFile,
                                        thumbnail: HTTPFile,
                                        description: String,
                                        focus: (Double, Double)
                                    ) -> MastodonAPI.Transaction<MastodonAPI.Entities.MediaAttachment> {
        let bodyParams = HTTPParams([
            "description": description,
            "focus": "(\(focus.0),\(focus.1))"
        ])

        bodyParams.add(param: "file", file: file)
        bodyParams.add(param: "thumbnail", file: thumbnail)

        let urlRequest = constructURLRequest(method: .POST, uriTemplate: "/api/v2/media", requiresAuthToken: true, requiredScope: .write_media, bodyMultipartFormData: bodyParams.asMultipartFormData)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func getMediaAttachment(id: String) -> MastodonAPI.Transaction<MastodonAPI.Entities.MediaAttachment> {
        let urlRequest = constructURLRequest(method: .GET, uriTemplate: "/api/v1/media/\(id)", requiresAuthToken: true, requiredScope: .write_media)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }

    public func updateMediaAttachment(
                                        id: String,
                                        thumbnail: HTTPFile? = nil,
                                        description: String? = nil,
                                        focus: (Double, Double)? = nil
                                    ) -> MastodonAPI.Transaction<MastodonAPI.Entities.MediaAttachment> {
        let bodyParams = HTTPParams([
            "description": description as Any,
        ])

        if let focus {
            bodyParams.add(param: "focus", value:"(\(focus.0),\(focus.1))")
        }
        if let thumbnail {
            bodyParams.add(param: "thumbnail", file: thumbnail)
        }
        let urlRequest = constructURLRequest(method: .PUT, uriTemplate: "/api/v1/media/\(id)", requiresAuthToken: true, requiredScope: .write_media, bodyMultipartFormData: bodyParams.asMultipartFormData)
        return .init(urlSession: urlSession, urlRequest: urlRequest, cacheManager: cacheManager)
    }
}
