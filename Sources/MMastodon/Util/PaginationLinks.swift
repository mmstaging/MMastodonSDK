extension MastodonAPI {

    ///
    /// From Mastodon Documentation:
    ///     - The links will be returned all via one Link header, separated by a comma and a space (, )
    ///     - Each link consists of a URL and a link relation, separated by a semicolon and a space (; )
    ///     - The URL will be surrounded by angle brackets (<>), and the link relation will be surrounded by double quotes ("") and prefixed with rel=.
    ///     - The value of the link relation will be either prev or next.
    ///     - Following the next link should show you older results. Following the prev link should show you newer results.
    ///
    ///  seeAlso: https://docs.joinmastodon.org/api/guidelines/#pagination
    public class PaginationLinks {

        private enum Page: String, Hashable {
            case prev, next
        }

        public var prev: HTTPParams? { parsedLinks[.prev] }
        public var next: HTTPParams? { parsedLinks[.next] }

        public var both: HTTPParams? {
            let result = HTTPParams()
            result.add(params: prev)
            result.add(params: next)
            return result
        }

        private let parsedLinks: [Page: HTTPParams]

        public init(headerValue: String = "") {
            parsedLinks = PaginationLinks.parseLinks(from: headerValue)
        }

        public convenience init(headers: [String: String]?) {
            guard let headers = headers else { self.init(); return }
            if let link = headers["Link"] {
                self.init(headerValue: link)
            } else {
                for key in headers.keys where key.lowercased() == "link" {
                    self.init(headerValue: headers[key]!)
                    return
                }
                self.init()
            }
        }

        /// result will be empty Dictionary if error
        /// <https://url.com/api/v2/blah?max_id=123456>; rel="next", <https://url.com/api/v2/blah?since_id=765432>; rel="prev"
        static private func parseLinks(from headerValue: String) -> [Page: HTTPParams] {
            var parsedLinks = [Page: HTTPParams]()

            func extractQueryParams(from capture: Substring) -> HTTPParams {
                let queryParams = capture.split(separator: "&")
                let parsedQueryParams = queryParams.reduce(into: [String: String]()) { result, rawParam in
                    let components = rawParam.split(separator: "=").map(String.init)
                    result[components[0]] = components[1]
                }
                return HTTPParams(parsedQueryParams)
            }

            let httpLinkRegex = #/<.*\?(?<queryString>.*)>; rel="(?<rel>.*)"/#

            for component in headerValue.split(separator: ", ") {
                if let result = try? httpLinkRegex.wholeMatch(in: component) {
                    if let page = Page(rawValue: String(result.rel)) {
                        parsedLinks[page] = extractQueryParams(from: result.queryString)
                    }
                }
            }

            return parsedLinks
        }
    }
}
