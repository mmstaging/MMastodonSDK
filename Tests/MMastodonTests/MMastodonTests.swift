import XCTest
@testable import MMastodon

let WEBSITE = "https://app.joinmastodon.org/ios"
let SCHEME = ProcessInfo.processInfo.environment["HTTP_SCHEME"] ?? "https"
let DOMAIN = ProcessInfo.processInfo.environment["HTTP_DOMAIN"] ?? "localhost:8080"

final class MMastodonTests: XCTestCase {
    func testExample() throws {
        // XCTest Documenation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods

        print(ProcessInfo.processInfo.environment.keys)
    }


    func testHello() async throws {
        let s = MastodonAPI.SessionContext(scheme: SCHEME, domain: DOMAIN)
        let transaction = s.createApplication(
                                                redirect_uris: "mastodon://joinmastodon.org/oauth",
                                                website: WEBSITE,
                                                client_name: "Mastodon",
                                                scopes: [.read, .write, .follow, .push]
                                            )
        let (application, response) = try await transaction.getEntity()
        XCTAssertEqual(application.website, "https://app.joinmastodon.org/ios")
        XCTAssertEqual(response.statusCode, 200, "Create Application API call failed")

    }
}
