//
//  ProfileAPIClientTests.swift
//  WhatsVassTests
//
//  Created by Adrian Iraizos Mendoza on 7/5/24.
//

import XCTest

@testable import WhatsVass

final class ProfileAPIClientTests: XCTestCase {
    var sut: ProfileAPIClient!
    
    override func setUpWithError() throws {
        sut = ProfileAPIClient()
    }

    override func tearDownWithError() throws {
        sut = nil
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
