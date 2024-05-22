//
//  ChatAPIClientTests.swift
//  WhatsVassTests
//
//  Created by Adrian Iraizos Mendoza on 7/5/24.
//

import XCTest

@testable import WhatsVass
final class ChatAPIClientTests: XCTestCase {

    var sut: ChatAPIClient!
    
    override func setUpWithError() throws {
        sut = ChatAPIClient()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testGetChatMessage_ShouldBe10() async throws {
        let message = try await sut.getChatMessagesByAPI(chat: "", first: 0)
        XCTAssertEqual(message.count, 12)
    }
    
    func testSendMessage_ShouldBeTrue() async throws {
      let params = ["chat": "test chat",
                                     "source": "source",
                                     "message": "Test message"]
        let response = try await sut.sendMessage(params: params)
        XCTAssertTrue(response.success)
    }
}
