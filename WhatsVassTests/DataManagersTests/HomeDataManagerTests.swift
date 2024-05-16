//
//  HomeDataManagerTests.swift
//  WhatsVassTests
//
//  Created by Adrian Iraizos Mendoza on 8/5/24.
//

import XCTest
import Combine

@testable import WhatsVass

final class HomeDataManagerTests: XCTestCase {
    var api: HomeAPIClient!
    var sut: HomeDataManager!
    var subscribers: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        api = HomeAPIClient(urlProtocol: URLSessionMock.self)
        sut = HomeDataManager(apiClient: api)
        subscribers = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        api = nil
        sut = nil
        subscribers = nil
    }
    func testGetChats_ShouldBe3_MockNick() {
        let expectation = XCTestExpectation(description: "Carga GetChats")
        sut.getChats()
            .sink(receiveCompletion: { completion in
                switchCompletion(completion, expectation)
            }, receiveValue: { response in
                XCTAssertEqual(response.count, 4)
                let first = try! XCTUnwrap(response.first)
                XCTAssertEqual(first.sourcenick, "Mock Nick")
            })
            .store(in: &subscribers)
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed)
    }
    
    func testGetMessages_ShouldBe7_MockAvatar() {
        let expectation = XCTestExpectation(description: "Carga GeMessages")
        
        sut.getMessages()
            .sink(receiveCompletion: { completion in
                switchCompletion(completion, expectation)
            }, receiveValue: { response in
                XCTAssertEqual(response.count, 7)
                let first = try! XCTUnwrap(response.first)
                XCTAssertEqual(first.avatar, "Mock Avatar")
            })
            .store(in: &subscribers)
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed)
    }
    
    func testDeleteChat_ShouldBeTrue() {
        let expectation = XCTestExpectation(description: "Carga DeleteChat")
        sut.deleteChat(chatId: "1")
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
