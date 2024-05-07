//
//  SettingsAPIClientTests.swift
//  WhatsVassTests
//
//  Created by Adrian Iraizos Mendoza on 7/5/24.
//

import XCTest
import Combine

@testable import WhatsVass
final class SettingsAPIClientTests: XCTestCase {
    var sut: SettingsAPIClient!
    var subscribers: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        sut = SettingsAPIClient()
        subscribers = Set<AnyCancellable>()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        subscribers = nil
    }
    
    func testLogout() {
        let expectation = XCTestExpectation(description: "Carga Logout")
        
        sut.logout()
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail(error.description())
                }
            } receiveValue: { response in
                XCTAssertEqual(response.message,"logout success")
            }
            .store(in: &subscribers)
        
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed)
    }
    
}
