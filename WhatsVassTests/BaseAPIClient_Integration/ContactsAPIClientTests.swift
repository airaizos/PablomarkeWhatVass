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
    
    func testGetContacts_ShouldBe447() async throws {
       let user = try await sut.getContacts()
        XCTAssertGreaterThan(user.count, 0)
    }
    
    func testCreateChate_shouldBeTrue() async throws {
        let source = "Test Source"
        let target = "test target"
        let response = try await sut.createChat(source: source, target: target)
        XCTAssertTrue(response.success)
        XCTAssertEqual(response.chat.source, "Mock Source")

    }
    
    func testGetChats_ShouldBe() async throws {
     let chat = try await sut.getChats()
        XCTAssertGreaterThan(chat.count, 0)

    }
}
