import Foundation
import Logging

private actor SimpleCounter {
    private var counter = 1
    func nextTick() -> Int {
        counter += 1
        return counter
    }
}

private let simpleCounter = SimpleCounter()


extension MastodonAPI {
    public enum TransactionError: Error {
        case notSuccessful(HTTPURLResponse)
    }

    public class Transaction<T:Codable> {
        unowned let urlSession: URLSession
        var urlRequest: URLRequest
        var response: MastodonAPI.HTTPResponse<T>
        var logger: Logger

        public init(urlSession: URLSession, urlRequest: URLRequest) {
            self.urlSession = urlSession
            self.urlRequest = urlRequest
            response = .init()
            logger = Logger(label: "mmpub.MMastodon.\(UUID().uuidString)")
        }

        public func getEntity() async throws -> (T, HTTPURLResponse)  {
            let counter = await simpleCounter.nextTick()
            logger.info("[HTTP REQUEST] #\(counter) \(urlRequest.cURLString)")
            let (data, response) = try await urlSession.data(for: urlRequest)
            let httpResponse = response as! HTTPURLResponse
            logger.info("[HTTP RESPONSE] #\(counter) \(httpResponse.statusCode)")
            guard httpResponse.statusCode == 200 else { throw TransactionError.notSuccessful(httpResponse) }
            let dto = try JSONDecoder().decode(T.self, from: data)
            return (dto, httpResponse)
        }

        public func getEntityAndLinks() async throws -> (T, PaginationLinks, HTTPURLResponse)  {
            let (entity, response) = try await getEntity()
            return (entity, PaginationLinks(headers: response.allHeaderFields as? [String: String]), response)
        }
    }
}
