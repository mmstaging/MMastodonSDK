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
    public struct HTTPLink {
        public enum `Type`: String {
            case prev, next
        }

        public let prevParams = HTTPParams?
        public let nextParams = HTTPParams?

        init?(linkHeader: String) {
            let parsedLinks = parseLinks()
            guard !parsedLinks.isEmpty else { return nil }
            
        }

        /// result will be empty Dictionary if error
        /// <https://url.com/api/v2/blah?max_id=123456>; rel="next", <https://url.com/api/v2/blah?since_id=765432>; rel="prev"
        func parseLinks() -> [String:String] {

            return result
        }
    }
}
