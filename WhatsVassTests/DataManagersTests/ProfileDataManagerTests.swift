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

    func testCreateAndRegisterProfile_ShouldBeTrue() async throws {
       // let expection = XCTestExpectation(description: "Carga CreateAnRegisterProfile")
        
       let response = try await sut.createAndRegisterProfile(params: profileCredentials)
        XCTAssertTrue(response.success)
        XCTAssertEqual(response.user.token, "Mock Token")
//            .sink { completion in
//                switchCompletion(completion, expection)
//            } receiveValue: { response in
//               
//            }
//            .store(in: &subscribers)
//        
//        let result = XCTWaiter.wait(for: [expection], timeout: 5)
//        XCTAssertEqual(result, .completed)
    }
}
