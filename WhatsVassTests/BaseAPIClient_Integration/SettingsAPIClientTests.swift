//
//  SettingsAPIClientTests.swift
//  WhatsVassTests
//
//  Created by Adrian Iraizos Mendoza on 7/5/24.
//

import XCTest

@testable import WhatsVass
final class SettingsAPIClientTests: XCTestCase {
    var sut: SettingsAPIClient!
    
    override func setUpWithError() throws {
        sut = SettingsAPIClient()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testLogout() async throws {
        
        let response = try await sut.logout()
        XCTAssertEqual(response.message,"Mock Message")
    }
    
}
