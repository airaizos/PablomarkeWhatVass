//
//  SettingsDataManagerTests.swift
//  WhatsVassTests
//
//  Created by Adrian Iraizos Mendoza on 8/5/24.
//

import XCTest
import Combine

@testable import WhatsVass
final class SettingsDataManagerTests: XCTestCase {
    var api: SettingsAPIClient!
    var sut: SettingsDataManager!
    var subscribers: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        api = SettingsAPIClient(urlProtocol: URLSessionMock.self)
        sut = SettingsDataManager(apiClient: api)
        subscribers = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        api = nil
        sut = nil
        subscribers = nil
    }

    func testLogOut_ShouldBe() {
        let expectation = XCTestExpectation()
        sut.logOut()
            .sink { completion in
                switchCompletion(completion, expectation)
            } receiveValue: { response in
                XCTAssertEqual(response.message, "Mock Message")
            }
            .store(in: &subscribers)
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed)
    }
}
