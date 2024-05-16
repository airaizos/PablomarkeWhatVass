//
//  SettingsAPIClientTests.swift
//  WhatsVassTests
//
//  Created by Adrian Iraizos Mendoza on 7/5/24.
//

import XCTest
import Combine

@testable import WhatsVass
final class SettingsAPIClientTests: XCTestCase {
    var sut: SettingsAPIClient!
    var subscribers: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        sut = SettingsAPIClient()
        subscribers = Set<AnyCancellable>()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        subscribers = nil
    }
    
    func testLogout() async throws {
        
        let response = try await sut.logout()
        XCTAssertEqual(response.message,"Mock Message")
    }
    
}
