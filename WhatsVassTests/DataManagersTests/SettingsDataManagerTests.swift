//
//  SettingsDataManagerTests.swift
//  WhatsVassTests
//
//  Created by Adrian Iraizos Mendoza on 8/5/24.
//

import XCTest

@testable import WhatsVass
final class SettingsDataManagerTests: XCTestCase {
    var api: SettingsAPIClient!
    var sut: SettingsDataManager!
    
    override func setUpWithError() throws {
        api = SettingsAPIClient(urlProtocol: URLSessionMock.self)
        sut = SettingsDataManager(apiClient: api)
    }

    override func tearDownWithError() throws {
        api = nil
        sut = nil
    }

    func testLogOut_ShouldBe() async throws {
        let response = try await sut.logout()
        XCTAssertEqual(response.message, "Mock Message")
    }
}
