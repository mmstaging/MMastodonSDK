import Foundation

extension MastodonAPI {

    public enum HTTPRequestFactoryError: Error {
        case templateKeyNotFound
    }

    public struct SessionContextConfig {
        public let scheme: String
        public let domain: String
        public var urlSession: URLSession? = nil
    }

    public class SessionContext {
        public typealias HTTPParams = MastodonAPI.HTTPParams
        public typealias HTTPFile = MastodonAPI.HTTPFile
        public typealias PaginationLinks = MastodonAPI.PaginationLinks

        internal var uriTemplateValues = [String:String]()
        internal var headerTemplateValues = [String:String]()
        internal var authToken: MastodonAPI.Entities.Token?
        internal let urlSession: URLSession


        public init(scheme: String, domain: String, urlSession: URLSession? = nil, authToken: MastodonAPI.Entities.Token? = nil) {
            uriTemplateValues["{scheme}"] = scheme
            uriTemplateValues["{domain}"] = domain
            self.urlSession = urlSession ?? URLSession(configuration: .default)
            self.authToken = authToken
        }

        public func getUriTemplateValues() -> [String: String] {
            uriTemplateValues
        }

        public func setHeaderTemplateValue(template: String, value: String) {
            headerTemplateValues[template] = value
        }

        // non-idempotent delete. Throws error if key is not present.
        public func tryDeleteHeaderTemplateValue(template: String) throws {
            guard headerTemplateValues[template] != nil
            else {
                throw HTTPRequestFactoryError.templateKeyNotFound
            }
            headerTemplateValues[template] = nil
        }

        // idempotent delete.
        public func deleteHeaderTemplateValue(template: String) {
            headerTemplateValues[template] = nil
        }

        public func getHeaderTemplateValues() -> [String: String] {
            headerTemplateValues
        }

        // Factory Method
        public func constructURLRequest(
                        method: HTTPMethod,
                        uriTemplate: String,
                        queryParams: HTTPParams? = nil,
                        headers: [String:String] = [:],
                        requiresAuthToken: Bool = false,
                        requiredScope: OAuthScope? = nil,
                        bodyString: String? = nil,
                        bodyEncodable: Encodable? = nil,
                        bodyMultipartFormData: (Data, String)? = nil
                    ) -> URLRequest {

            //TODO: evaluated requiredScope

            let scheme = uriTemplateValues["{scheme}"]!
            let domain = uriTemplateValues["{domain}"]!
            let urlString = "\(scheme)://\(domain)\(uriTemplate)\(queryParams?.asQueryString ?? "")"

            var urlRequest = URLRequest(url: URL(string: urlString)!)
            var encoded = Data?.none
            if let bodyEncodable {
                let jsonEncoder = JSONEncoder()
                jsonEncoder.outputFormatting = .withoutEscapingSlashes
                encoded = try? jsonEncoder.encode(bodyEncodable)
            } else if let bodyString {
                encoded = bodyString.data(using: .utf8)
            }

            urlRequest.httpMethod = method.rawValue
            var headers = headers
            if let (data, boundary) = bodyMultipartFormData {
                headers["Content-Type"] = "multipart/form-data; charset=utf-8; boundary=\"\(boundary)\""
                urlRequest.httpBody = data
            } else if let encoded {
                headers["Content-Length"] = "\(encoded.count)"
                headers["Content-Type"] = "application/json; charset=utf-8"
                urlRequest.httpBody = encoded
            }
            if requiresAuthToken, let authToken {
                //TODO: check auth token for scopes
                headers["Authorization"] = "\(authToken.token_type) \(authToken.access_token)"
            }
            urlRequest.allHTTPHeaderFields = headers
            return urlRequest
        }

        public func set(authToken: MastodonAPI.Entities.Token) {
            self.authToken = authToken
        }


    }
}
