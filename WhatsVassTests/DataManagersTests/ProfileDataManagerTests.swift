//
//  ProfileDataManagerTests.swift
//  WhatsVassTests
//
//  Created by Adrian Iraizos Mendoza on 8/5/24.
//

import XCTest
import Combine

@testable import WhatsVass
final class ProfileDataManagerTests: XCTestCase {
    
    var api: ProfileAPIClient!
    var sut: ProfileDataManager!
    var subscribers: Set<AnyCancellable>!
    

    override func setUpWithError() throws {
        api = ProfileAPIClient(urlProtocol: URLSessionMock.self)
        sut = ProfileDataManager(apiClient: api)
        subscribers = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        api = nil
        sut = nil
        subscribers = nil
    }

    func testCreateAndRegisterProfile_ShouldBeTrue() {
        let expection = XCTestExpectation(description: "Carga CreateAnRegisterProfile")
        
        sut.createAndRegisterProfile(params: profileCredentials)
            .sink { completion in
                switchCompletion(completion, expection)
            } receiveValue: { response in
                XCTAssertTrue(response.success)
                XCTAssertEqual(response.user.token, "Mock Token")
            }
            .store(in: &subscribers)
        
        let result = XCTWaiter.wait(for: [expection], timeout: 5)
        XCTAssertEqual(result, .completed)
    }
}
