import XCTest
@testable import SecureNetworking

final class MockNetworking: URLSessionProtocol {
    var responseData: Data?
    var error: Error?
    var task: MockDataTask!

    func dataTask(with request: URLRequest,
                  completionHandler: @escaping  TaskResult)  -> URLSessionDataTaskProtocol {
        task = MockDataTask(responseData: responseData, error: error, taskResult: completionHandler)
        return task
    }
}

final class MockDataTask: URLSessionDataTaskProtocol {
    let responseData: Data?
    let error: Error?
    let taskResult: TaskResult
    var cancelCalled = false

    init(responseData: Data?, error: Error?, taskResult: @escaping TaskResult) {
        self.responseData = responseData
        self.error = error
        self.taskResult = taskResult
    }

    func resume() {
        taskResult(responseData, nil, error)
    }

    func cancel() {
        cancelCalled = true
    }
}
