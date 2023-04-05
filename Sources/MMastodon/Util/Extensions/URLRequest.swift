import Foundation

extension URLRequest {
    var cURLString: String {
        let headers = (allHTTPHeaderFields ?? [:]).map { "-H \"\($0.0): \($0.1)\"" }.sorted().joined(separator: " ")
        let body = httpBody == nil ? "" : "-d '" + String(data:httpBody!, encoding: .utf8)! + "'"
        var method = ""
        if let m = httpMethod, m != "GET" {
            method = "-X \(m)"
        }
        return  "curl \(method) \(headers) \"\(self)\"  \(body)"
    }
}
