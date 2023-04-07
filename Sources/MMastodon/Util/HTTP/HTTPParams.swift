import Foundation

extension MastodonAPI {

    fileprivate struct HTTPParam {
        let name: String
        /// unwrapped non-nil value from optional, if needed
        let value: String
        /// any value passed as Optional<X> will report here as X
        let valueType: String
        let isOptional: Bool
        let isNil: Bool
        let file: HTTPFile?

        init(param: String, value anyValue: Any = "", file: HTTPFile? = nil) {
            name = param

            if let optionalValue = anyValue as? ExpressibleByNilLiteral {
                isOptional = true
                isNil = "\(optionalValue)" == "nil"

                /// for types, "Optional<X>"; for values, "Optional(x)"
                /// this must handle both cases
                func stripOptional(_ s:String) -> String {
                    let prefixStr = "Optional"
                    guard String(s.prefix(prefixStr.count)) == prefixStr else { return s }
                    let wrapperSize = s.suffix(2) == "\")" ? 2 : 1 // Optional("string") case; want to remove quotes as well.
                    return String(Array(s)[(prefixStr.count+wrapperSize)...].dropLast(wrapperSize))
                }

                valueType = stripOptional("\(type(of: anyValue))")
                value = !isNil ? stripOptional("\(anyValue)") : "nil"
            } else {
                isOptional = false
                isNil = false
                valueType = "\(type(of: anyValue))"
                value = "\(anyValue)"
            }

            self.file = file
        }
    }

    public class HTTPParams {
        fileprivate var params = [HTTPParam]()

        public init() {}

        public init(_ params:[String:Any]) {
            for (param, value) in params {
                add(param: param, value: value)
            }
        }

        public convenience init?(_ params:[String:Any]?) {
            guard let params else { return nil }
            self.init(params)
        }

        public func add(param: String, value: Any="", file:HTTPFile? = nil) {
            params.append(HTTPParam(param: param, value: value, file:file))
        }

        public func add(params newParams: HTTPParams?) {
            if let newParams {
                params += newParams.params
            }
        }

        fileprivate func urlEscape(_ s: String) -> String {
            // Reference: https://www.rfc-editor.org/rfc/rfc3986
            let allowed = NSMutableCharacterSet.alphanumeric()
            allowed.addCharacters(in: "-._~/?")
            return s.addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet) ?? s
        }

        public var asQueryString: String {
            var names = [String]()
            var values = [String]()
            for param in params {
                guard !param.isNil else { continue }
                names.append(urlEscape(param.name))
                values.append("\(urlEscape("\(param.value)"))")
            }
            guard !names.isEmpty else { return "" }
            return  "?" +
                    zip(names, values)
                    .map { "\($0.0)=\($0.1)" }
                    .sorted { $0.lowercased() < $1.lowercased() } // sort query params as a courtesy for caches / diagnostic tools
                    .joined(separator: "&")
        }

        public var asJSON: String {
            generateJSON(pretty: false)
        }

        public var asPrettyJSON: String {
            generateJSON(pretty: true)
        }

        public var asMultipartFormData: (Data, String) {
            let CRLF = "\r\n", TAG = "--"
            var result = Data()
            let boundary = "X_\(UUID().uuidString.hashValue)_X"


            for param in params where !param.isNil {
                result.append((CRLF + TAG + boundary + CRLF).data(using: .utf8)!)
                result.append("Content-Disposition: form-data; name=\"\(param.name)\"".data(using: .utf8)!)
                if let file = param.file {
                    result.append("; filename=\"\(file.filename)\"".data(using: .utf8)!)
                }
                result.append(CRLF.data(using: .utf8)!)
                if let file = param.file {
                    result.append(("Content-Type: \(file.contentType.mimeType)"+CRLF).data(using: .utf8)!)
                }
                result.append(CRLF.data(using: .utf8)!)
                if let file = param.file {
                    result.append(file.content)
                } else {
                    result.append(String(param.value).data(using: .utf8)!)
                }
            }
            result.append((CRLF + TAG + boundary + TAG + CRLF).data(using: .utf8)!)

            return (result, boundary)
        }

        /// Create JSON Object, even if only one param
        fileprivate func generateJSON(pretty: Bool) -> String {
            var components = [String]()
            let prettySpace = pretty ? " " : ""

            for param in params where !param.isNil {
                var value = param.value
                if param.valueType == "String" {
                    value = "\"\(value)\""
                }
                components.append("\"\(param.name)\":\(prettySpace)\(value)")

            }
            if pretty && !components.isEmpty {
                return "{\n\t" + components.joined(separator: ",\n\t") + "\n}"
            }
            return "{" + components.joined(separator: ",") + "}"
        }
    }
}
