//
//  SettingsDataManagerTests.swift
//  WhatsVassTests
//
//  Created by Adrian Iraizos Mendoza on 8/5/24.
//

import XCTest
import Combine

@testable import WhatsVass
final class SettingsDataManagerTests: XCTestCase {
    var api: SettingsAPIClient!
    var sut: SettingsDataManager!
    var subscribers: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        api = SettingsAPIClient(urlProtocol: URLSessionMock.self)
        sut = SettingsDataManager(apiClient: api)
        subscribers = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        api = nil
        sut = nil
        subscribers = nil
    }

    func testLogOut_ShouldBe() async throws {
        let response = try await sut.logout()
        XCTAssertEqual(response.message, "Mock Message")
    }
}
