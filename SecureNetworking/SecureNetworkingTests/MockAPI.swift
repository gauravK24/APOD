import XCTest
@testable import SecureNetworking

enum MockAPI {
    case dummy
}

extension MockAPI: APIRequest {
    var url: URL {
        guard let url = URL(string: "www.dummyapi.com") else { fatalError("") }
        return url
    }

    var httpMethod: HTTPMethod {
        return .post
    }

    var httpBody: Data? {
        return nil
    }
}
