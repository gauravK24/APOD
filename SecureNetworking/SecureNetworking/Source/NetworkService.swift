import Foundation

public typealias TaskResult = (Data?, URLResponse?, Error?) -> Void

public protocol Networking {
    associatedtype Endpoint: APIRequest
    func fetch(_ endpoint: Endpoint, completion: @escaping (Result<AnyObject?, Error>) -> Void)
    func cancel()
}

public protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
}

public protocol URLSessionProtocol {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping  TaskResult)  -> URLSessionDataTaskProtocol
}

public final class NetworkService<EndPoint: APIRequest>: Networking {
    private var task: URLSessionDataTaskProtocol?
    private var session: URLSessionProtocol

    public init(session: URLSessionProtocol) {
        self.session = session
    }

    public func fetch(_ endpoint: EndPoint, completion: @escaping (Result<AnyObject?, Error>) -> Void) {
        let urlRequest = makeRequest(endpoint)

        task = session.dataTask(with: urlRequest) { (data, _, error) in

            // Error
            if let error = error {
                completion(.failure(error))
            }

            // Success
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data) as AnyObject {
                completion(.success(json))
            } else {
                completion(.success(nil))
            }
        }

        task?.resume()
    }

    public func cancel() {
        task?.cancel()
    }

    private func makeRequest(_ endpoint: EndPoint) -> URLRequest {
        let request = URLRequest(url: endpoint.url)
        return request
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

extension URLSession: URLSessionProtocol {
    public func dataTask(with request: URLRequest,
                         completionHandler: @escaping TaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}
