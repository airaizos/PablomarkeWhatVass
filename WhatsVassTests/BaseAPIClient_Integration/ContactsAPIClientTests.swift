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
    
    func testCreateChate_shouldBeTrue() async throws {
        let expectation = XCTestExpectation(description: "Carga CreateChat")
        let source = "Test Source"
        let target = "test target"
        let response = try await sut.createChat(source: source, target: target)
        XCTAssertTrue(response.success)
        XCTAssertEqual(response.chat.source, "Mock Source")
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    expectation.fulfill()
//                case .failure(let error):
//                    XCTFail(error.description())
//                }
//            } receiveValue: { response in
//               
//            }
//            .store(in: &subscribers)
//        
//        
//        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
//        XCTAssertEqual(result, .completed)
    }
    
    func testGetChats_ShouldBe() async throws {
       // let expectation = XCTestExpectation(description: "Carga GetChats")
        
     let chat = try await sut.getChats()
        XCTAssertGreaterThan(chat.count, 0)
//            .sink { completion in
//                switchCompletion(completion, expectation)
//            } receiveValue: { chat in
//              
//            }
//            .store(in: &subscribers)
//        
//        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
//        XCTAssertEqual(result, .completed)
    }
}
