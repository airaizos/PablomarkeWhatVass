//
//  ContactsDataManagerTests.swift
//  WhatsVassTests
//
//  Created by Adrian Iraizos Mendoza on 8/5/24.
//

import XCTest

@testable import WhatsVass
final class ContactsDataManagerTests: XCTestCase {
    var api: ContactsAPIClient!
    var sut: ContactsDataManager!
    
    override func setUpWithError() throws {
        api = ContactsAPIClient(urlProtocol: URLSessionMock.self)
        sut = ContactsDataManager(apiClient: api)
    }

    override func tearDownWithError() throws {
        api = nil
        sut = nil
    }
    
    func testGetContacts_ShouldBe3() async throws {
        
        let result = try await sut.getContacts()
        XCTAssertEqual(result.count, 3)
        let contact = try! XCTUnwrap(result.first)
        XCTAssertEqual(contact.nick, "Mock Nick")
    }

    func testCreateChat_ShouldBeMockSource() async throws {
        let response = try await sut.createChat(source: "", target: "")
        
        XCTAssertEqual(response.chat.source, "Mock Source")
        XCTAssertTrue(response.success)
    }
    
    func testGetChats_ShouldBeMockNick() async throws {
       let chats = try await sut.getChats()
        XCTAssertEqual(chats.count, 4)
        let first = try! XCTUnwrap(chats.first)
        XCTAssertEqual(first.sourcenick, "Mock Nick")
    }
}
