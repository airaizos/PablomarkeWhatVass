//
//  ContactsAPIClientTests.swift
//  WhatsVassTests
//
//  Created by Adrian Iraizos Mendoza on 7/5/24.
//

import XCTest
import Combine

@testable import WhatsVass
final class ContactsAPIClientTests: XCTestCase {
    var sut: ContactsAPIClient!
    var subscribers: Set<AnyCancellable>!
    
    
    override func setUpWithError() throws {
        sut = ContactsAPIClient()
        subscribers = Set<AnyCancellable>()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        subscribers = nil
    }
    
    func testGetContacts_ShouldBe447() {
        let expectation = XCTestExpectation(description: "Carga GetContacts")
        sut.getContacts()
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail(error.description())
                }
            } receiveValue: { user in
                XCTAssertGreaterThan(user.count, 0)
            }
            .store(in: &subscribers)
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed)
    }
    
    func testCreateChate_shouldBeTrue() {
        let expectation = XCTestExpectation(description: "Carga CreateChat")
        let source = "Test Source"
        let target = "test target"
        sut.createChat(source: source, target: target)
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail(error.description())
                }
            } receiveValue: { response in
                XCTAssertTrue(response.success)
                XCTAssertEqual(response.chat.source, "source_id")
            }
            .store(in: &subscribers)
        
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed)
    }
    
    func testGetChats_ShouldBe() {
        let expectation = XCTestExpectation(description: "Carga GetChats")
        
        sut.getChats()
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail(error.description())
                }
            } receiveValue: { chat in
                XCTAssertGreaterThan(chat.count, 0)
            }
            .store(in: &subscribers)
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed)
    }
}
