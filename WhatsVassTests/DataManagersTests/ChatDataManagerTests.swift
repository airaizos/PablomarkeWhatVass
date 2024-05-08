//
//  ChatDataManagerTests.swift
//  WhatsVassTests
//
//  Created by Adrian Iraizos Mendoza on 8/5/24.
//

import XCTest
import Combine

@testable import WhatsVass
final class ChatDataManagerTests: XCTestCase {
    var api: ChatAPIClient!
    var sut: ChatDataManager!
    var subscribers: Set<AnyCancellable>!
    
    
    override func setUpWithError() throws {
        api = ChatAPIClient(urlProtocol: URLSessionMock.self)
        sut = ChatDataManager(apiClient: api)
        subscribers = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        api = nil
        sut = nil
        subscribers = nil
    }

    func testGetChats_ShouldBe3() {
        let expectation = XCTestExpectation(description: "Carga de GetChats")
        sut.getChats(chat: "", first: 1)
            .sink { completion in
                switchCompletion(completion, expectation)
            } receiveValue: { message in
                XCTAssertEqual(message.count, 3)
                XCTAssertEqual(message.rows.count, 3)
                let text = try! XCTUnwrap(message.rows.first?.message)
                XCTAssertEqual(text,"Mock Message")
            }
            .store(in: &subscribers)
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed)
    }
    
    func testSendMessage_ShouldBeTrue() {
        let expectation = XCTestExpectation(description: "Carga de SendMessage")
        sut.sendMessage(params: sendMessageParams)
            .sink { completion in
                switchCompletion(completion, expectation)
            } receiveValue: { response in
                XCTAssertTrue(response.success)
            }
            .store(in: &subscribers)
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed)
        
    }

}
