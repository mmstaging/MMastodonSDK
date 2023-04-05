import Foundation

extension MastodonAPI {
    public struct HTTPFile {
    
        public enum ContentType: String {
            case bin, gif, html, jpg, json, mp4, png, svg, txt, webm

            public var mimeType: String {
                switch self {
                case .bin: return "application/octet-stream"
                case .gif: return "image/gif"
                case .html: return "text/html"
                case .jpg: return "image/jpeg"
                case .json: return "application/json"
                case .mp4: return "video/mp4"
                case .png: return "image/png"
                case .svg: return "image/svg+xml"
                case .txt: return "text/plain"
                case .webm: return "video/webm"
                }
            }
        }

        public let filename: String
        public let content: Data
        public let contentType: ContentType

        public init(filename: String? = nil, content: Data, contentType: ContentType) {
            self.filename = filename ?? UUID().uuidString + "." + contentType.rawValue
            self.content = content
            self.contentType = contentType
        }

        /// Content size in bytes
        public var contentSize: Int {
            content.count
        }
    }
}
