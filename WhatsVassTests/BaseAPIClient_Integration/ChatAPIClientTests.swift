//
//  ChatAPIClientTests.swift
//  WhatsVassTests
//
//  Created by Adrian Iraizos Mendoza on 7/5/24.
//

import XCTest
import Combine

@testable import WhatsVass
final class ChatAPIClientTests: XCTestCase {

    var sut: ChatAPIClient!
    var subscribers: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        sut = ChatAPIClient()
        subscribers = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        sut = nil
        subscribers = nil
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
