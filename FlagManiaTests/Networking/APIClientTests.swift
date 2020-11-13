//
//  APIClientTests.swift
//  FlagManiaTests
//
//  Created by David Anglin on 11/12/20.
//

import XCTest
@testable import FlagMania

class APIClientTests: XCTestCase {
    
    var session: MockURLSession!
    var apiClient: APIClient!
    
    override func setUp() {
        super.setUp()
        self.session = createMockSession()
        self.apiClient = createClient(session: self.session)
    }
    
    override func tearDown() {
        session = nil
        apiClient = nil
        super.tearDown()
    }

    func test_apiClient_callsCompletion() {
        let session = createMockSession()
        let apiClient = createClient(session: session)
        
        var completionCalled = false
        
        apiClient.get(url: URL(string: "https://")!) { _, _ in
            completionCalled = true
        }
        
        XCTAssertTrue(completionCalled)
    }
    
    func test_apiClient_calls_correctURL() {
        let session = createMockSession()
        let apiClient = createClient(session: session)
        
        let url = URL(string: "https://")!
        apiClient.get(url: url) { _,_ in }
        
        XCTAssertEqual(session.currentURL, url)
    }
    
    func testapiClient_resumesTask() {
        let dataTask = MockURLDataTask()
        let session = createMockSession(dataTask: dataTask)
        let apiClient = createClient(session: session)
        
        apiClient.get(url: URL(string: "https://")!) { _, _ in }
        
        XCTAssertTrue(dataTask.resumeCalled)
    }
}

// MARK: - Helpers -
extension APIClientTests {
    
    private func createMockSession(dataTask: MockURLDataTask = MockURLDataTask()) -> MockURLSession {
        return MockURLSession(dataTask: dataTask)
    }
    
    private func createClient(session: MockURLSession) -> APIClient {
        return APIClient(urlSession: session)
    }
}

final class MockURLDataTask: URLSessionDataTaskProtocol {

    var resumeCalled = false

    func resume() {
        resumeCalled = true
    }
}

final class MockURLSession: URLSessionProtocol {
    
    var dataTask: URLSessionDataTaskProtocol
    var currentURL: URL?

    init(dataTask: URLSessionDataTaskProtocol) {
         self.dataTask = dataTask
     }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.DataTaskResult) -> URLSessionDataTaskProtocol {
        currentURL = request.url
        completionHandler(nil, nil, nil)
        return dataTask
    }
}

