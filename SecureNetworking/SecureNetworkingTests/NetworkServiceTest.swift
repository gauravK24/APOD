import XCTest
@testable import SecureNetworking

class NetworkServiceTest: XCTestCase {
    private var sut: NetworkService<MockAPI>!
    private var network: MockNetworking!

    override func setUpWithError() throws {
        try super.setUpWithError()
        network = MockNetworking()
        sut = NetworkService<MockAPI>(session: network)
    }

    override func tearDownWithError() throws {
        sut = nil
        network = nil
        try super.tearDownWithError()
    }

    func testFetch_withValidResponseData() {
        var result: AnyObject? = nil
        network.responseData = getReponseData()

        sut.fetch(.dummy) { response in
            guard case .success(let data) = response else { return }
            result = data
        }

        XCTAssertNotNil(result, "Response data should not be nil")
    }

    func testFetch_withInvalidResponseData() {
        var result: AnyObject? = nil
        network.responseData = nil

        sut.fetch(.dummy) { response in
            guard case .success(let data) = response else { return }
            result = data
        }

        XCTAssertNil(result, "Response data should be nil")
    }

    func testCancel_shouldCallDataTaskIsCancelCalled() {
        network.responseData = getReponseData()
        sut.fetch(.dummy) { _ in }

        sut.cancel()

        XCTAssertTrue(network.task.cancelCalled)
    }

    private func getReponseData() -> Data {
        let jsonString = """
        [
            {
                "name": "Taylor Swift",
                "age": 26
            },
            {
                "name": "Justin Bieber",
                "age": 25
            }
        ]
        """
        return Data(jsonString.utf8)
    }
}
