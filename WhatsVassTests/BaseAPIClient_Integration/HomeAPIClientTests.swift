//
//  HomeAPIClientTests.swift
//  WhatsVassTests
//
//  Created by Adrian Iraizos Mendoza on 7/5/24.
//

import XCTest

@testable import WhatsVass
final class HomeAPIClientTests: XCTestCase {
    var sut: HomeAPIClient!
    
    override func setUpWithError() throws {
        sut = HomeAPIClient()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
   
    func testGetChats_ShouldBe3() async throws {
        let chats = try await sut.getChats()
        XCTAssertGreaterThan(chats.count, 0)
    }
    
    func testGetMessages_ShouldBe1177() async throws {
        let response = try await sut.getMessages()
        XCTAssertGreaterThan(response.count, 0)
    }
    
    func testDeleteChat_ShouldBeTrue() async throws  {
       let response =  try await sut.deleteChat(chatId: "1")
        XCTAssertEqual(response.success, true)
    }
}
