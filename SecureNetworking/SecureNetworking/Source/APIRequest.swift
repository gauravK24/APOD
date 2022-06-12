import Foundation

public enum HTTPMethod: String {
    case post = "POST"
}

public protocol APIRequest {
    var url: URL { get }
    var httpMethod: HTTPMethod { get }
}
