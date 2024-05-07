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

    func testCreateAndRegisterProfileInAPI_ShouldBe() {
        let expectation = XCTestExpectation(description: "Carga createAndRegisterProfileInAPI")
        let params = ["login": "usuario",
                      "password": "password",
                      "nick": "nick",
                      "platform": "ios",
                      "firebaseToken": "NoTokenNow"]
        sut.createAndRegisterProfileInAPI(params: params)
       
            .sink { completion in
                switchCompletion(completion, expectation)
            } receiveValue: { response in
                XCTAssertTrue(response.success)
            }
            .store(in: &subscribers)
        
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed)
    }
   

}
