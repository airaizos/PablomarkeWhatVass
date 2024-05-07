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

    func testGetChatMessage_ShouldBe10() {
        let expectation = XCTestExpectation(description: "Carga GetChatMessage")
        sut.getChatMessagesByAPI(chat: "", first: 0)
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail(error.description())
                }
            } receiveValue: { message in
                XCTAssertGreaterThan(message.rows.count, 0)
            }
            .store(in: &subscribers)

        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed)
    }
    
    func testSendMessage_ShouldBeTrue() {
        let expectation = XCTestExpectation(description: "Carga SendMessage")
      let params = ["chat": "test chat",
                                     "source": "source",
                                     "message": "Test message"]
        sut.sendMessage(params: params)
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail(error.description())
                }
            } receiveValue: { response in
                XCTAssertTrue(response.success)
            }
            .store(in: &subscribers)

        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed)
    }
}
