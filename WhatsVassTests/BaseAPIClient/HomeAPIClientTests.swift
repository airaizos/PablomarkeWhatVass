//
//  HomeAPIClientTests.swift
//  WhatsVassTests
//
//  Created by Adrian Iraizos Mendoza on 7/5/24.
//

import XCTest
import Combine

@testable import WhatsVass
final class HomeAPIClientTests: XCTestCase {
    var sut: HomeAPIClient!
    var subscribers: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        sut = HomeAPIClient()
        subscribers = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        sut = nil
        subscribers = nil
    }

   
    func testGetChats_ShouldBe3() {
        let expectation = XCTestExpectation(description: "Carga de get Chats")
        
        sut.getChats()
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail(error.description())
                }
            } receiveValue: { chats in
                XCTAssertGreaterThan(chats.count, 0)
            }
            .store(in: &subscribers)
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed)
    }
    
    func testGetMessages_ShouldBe1177() {
        let expectation = XCTestExpectation(description: "Carga Get Messages")
        
        sut.getMessages()
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail(error.description())
                }
            } receiveValue: { response in
                XCTAssertGreaterThan(response.count, 0)
            }
            .store(in: &subscribers)
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed)
    }
    
    func testDeleteChat_ShouldBeTrue() {
        let expectation = XCTestExpectation(description: "carga de deleteChat")
        
        sut.deleteChat(chatId: "1")
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail(error.description())
                }
            } receiveValue: { response in
                XCTAssertEqual(response.success, true)
            }
            .store(in: &subscribers)

        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed)
       
    }

}
