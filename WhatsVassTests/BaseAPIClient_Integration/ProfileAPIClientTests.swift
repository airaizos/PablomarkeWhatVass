//
//  ProfileAPIClientTests.swift
//  WhatsVassTests
//
//  Created by Adrian Iraizos Mendoza on 7/5/24.
//

import XCTest
import Combine

@testable import WhatsVass

final class ProfileAPIClientTests: XCTestCase {
    var sut: ProfileAPIClient!
    var subscribers: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        sut = ProfileAPIClient()
        subscribers = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        sut = nil
        subscribers = nil
    }

    func testCreateAndRegisterProfileInAPI_ShouldBe() async throws {
        let params = ["login": "usuario",
                      "password": "password",
                      "nick": "nick",
                      "platform": "ios",
                      "firebaseToken": "NoTokenNow"]
        let response = try await sut.createAndRegisterProfileInAPI(params: params)
        XCTAssertTrue(response.success)
    }
   

}
