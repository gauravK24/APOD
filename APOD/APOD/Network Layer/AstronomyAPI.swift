import Foundation
import SecureNetworking

enum AstronomyAPI {
    case info
}

extension AstronomyAPI: APIRequest {
    var url: URL {
        guard let url = URL(string: RequestConstant.url) else { fatalError("") }
        return url
    }

    var httpMethod: HTTPMethod {
        return .post
    }
}

