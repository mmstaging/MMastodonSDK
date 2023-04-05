import Foundation

extension MastodonAPI {
    public class HTTPResponse<T: Codable> {
        var responseHeaders = [String: String]()
        var responseBody = T?.none
    }
}
