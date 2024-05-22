//
//  ChatDataManagerTests.swift
//  WhatsVassTests
//
//  Created by Adrian Iraizos Mendoza on 8/5/24.
//

import XCTest

@testable import WhatsVass
final class ChatDataManagerTests: XCTestCase {
    var api: ChatAPIClient!
    var sut: ChatDataManager!
    
    
    override func setUpWithError() throws {
        api = ChatAPIClient(urlProtocol: URLSessionMock.self)
        sut = ChatDataManager(apiClient: api)
    }

    override func tearDownWithError() throws {
        api = nil
        sut = nil
    }

    func testGetChats_ShouldBe4() async throws {
       let message = try await sut.getChats(chat: "", first: 1)
        XCTAssertEqual(message.count, 12)
        XCTAssertEqual(message.rows.count, 12)
        
    }
    
    func testSendMessage_ShouldBeTrue() async throws {
        let response = try await sut.sendMessage(params: sendMessageParams)
        XCTAssertTrue(response.success)
    }

}
