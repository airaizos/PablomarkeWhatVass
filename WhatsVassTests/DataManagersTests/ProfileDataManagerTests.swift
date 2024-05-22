//
//  ProfileDataManagerTests.swift
//  WhatsVassTests
//
//  Created by Adrian Iraizos Mendoza on 8/5/24.
//

import XCTest

@testable import WhatsVass
final class ProfileDataManagerTests: XCTestCase {
    
    var api: ProfileAPIClient!
    var sut: ProfileDataManager!
    

    override func setUpWithError() throws {
        api = ProfileAPIClient(urlProtocol: URLSessionMock.self)
        sut = ProfileDataManager(apiClient: api)
    }

    override func tearDownWithError() throws {
        api = nil
        sut = nil
    }

    func testCreateAndRegisterProfile_ShouldBeTrue() async throws {
        
       let response = try await sut.createAndRegisterProfile(params: profileCredentials)
        XCTAssertTrue(response.success)
        XCTAssertEqual(response.user.token, "Mock Token")
    }
}
