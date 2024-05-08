//
//  ContactsDataManagerTests.swift
//  WhatsVassTests
//
//  Created by Adrian Iraizos Mendoza on 8/5/24.
//

import XCTest
import Combine

@testable import WhatsVass
final class ContactsDataManagerTests: XCTestCase {
    var api: ContactsAPIClient!
    var sut: ContactsDataManager!
    var subscribers: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        api = ContactsAPIClient(urlProtocol: URLSessionMock.self)
        sut = ContactsDataManager(apiClient: api)
        subscribers = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        api = nil
        sut = nil
        subscribers = nil
    }
    
    func testGetContacts_ShouldBe3() {
        let expectation = XCTestExpectation()
        
        sut.getContacts()
            .sink { completion in
                switchCompletion(completion, expectation)
            } receiveValue: { result in
                XCTAssertEqual(result.count, 3)
                let contact = try! XCTUnwrap(result.first)
                XCTAssertEqual(contact.nick, "Mock Nick")
            }
            .store(in: &subscribers)
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed)
    }

    func testCreateChat_ShouldBeMockSource() {
        let expectation = XCTestExpectation()
        
        sut.createChat(source: "", target: "")
            .sink { completion in
                switchCompletion(completion, expectation)
            } receiveValue: { response in
                XCTAssertEqual(response.chat.source, "Mock Source")
                XCTAssertTrue(response.success)
            }
            .store(in: &subscribers)
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed)
    }
    
    func testGetChats_ShouldBeMockNick() {
        let expectation = XCTestExpectation()
        sut.getChats()
            .sink { completion in
                switchCompletion(completion, expectation)
            } receiveValue: { chats in
                XCTAssertEqual(chats.count, 3)
                let first = try! XCTUnwrap(chats.first)
                XCTAssertEqual(first.sourcenick, "Mock Nick")
            }
            .store(in: &subscribers)
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed)
    }
    
    //agetChats
    
}
