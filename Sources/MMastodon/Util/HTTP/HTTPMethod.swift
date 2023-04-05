extension MastodonAPI {
    /// Source: https://www.rfc-editor.org/rfc/rfc9110.html#name-method-definitions
    public enum HTTPMethod: String {
        /// Transfer a current representation of the target resource.
        case GET
        /// Same as GET, but do not transfer the response content.
        case HEAD
        /// Perform resource-specific processing on the request content.
        case POST
        /// Replace all current representations of the target resource with the request content.
        case PUT
        /// Remove all current representations of the target resource.
        case DELETE
        /// Establish a tunnel to the server identified by the target resource.
        case CONNECT
        /// Describe the communication options for the target resource.
        case OPTIONS
        /// Perform a message loop-back test along the path to the target resource.
        case TRACE
        /// Partially modify representations of the target resource.
        case PATCH

        public var asString: String { self.rawValue }

        /// Reasonable use of a safe method is not expected to cause any harm, loss of property, or unusual burden on the origin server
        public var isSafe: Bool {
            switch self {
            case .GET, .HEAD, .OPTIONS, .TRACE:
                return true
            default:
                return false
            }
        }

        /// A request method is considered "idempotent" if the intended effect on the server of multiple identical requests with that method is the same as the effect for a single such request.
        public var isIdempotent: Bool {
            // All safe methods are idempotent.
            guard !self.isSafe else { return true}

            switch self {
            case .PUT, .DELETE:
                return true
            default:
                return false
            }
        }
    }
}
