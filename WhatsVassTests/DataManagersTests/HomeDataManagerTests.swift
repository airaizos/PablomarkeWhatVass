//
//  HomeDataManagerTests.swift
//  WhatsVassTests
//
//  Created by Adrian Iraizos Mendoza on 8/5/24.
//

import XCTest

@testable import WhatsVass

final class HomeDataManagerTests: XCTestCase {
    var api: HomeAPIClient!
    var sut: HomeDataManager!
    
    override func setUpWithError() throws {
        api = HomeAPIClient(urlProtocol: URLSessionMock.self)
        sut = HomeDataManager(apiClient: api)
    }

    override func tearDownWithError() throws {
        api = nil
        sut = nil
    }
    func testGetChats_ShouldBe3_MockNick() async throws {
        let response = try await sut.getChats()
        
        XCTAssertEqual(response.count, 4)
        let first = try! XCTUnwrap(response.first)
        XCTAssertEqual(first.sourcenick, "Mock Nick")
    }
    
    func testGetMessages_ShouldBe7_MockAvatar() async throws {
        
       let response = try await sut.getMessages()
        XCTAssertEqual(response.count, 7)
        let first = try! XCTUnwrap(response.first)
        XCTAssertEqual(first.avatar, "Mock Avatar")
    }
    
    func testDeleteChat_ShouldBeTrue() async throws {
       let response = try await sut.deleteChat(chatId: "1")
        XCTAssertTrue(response.success)
    }
}
