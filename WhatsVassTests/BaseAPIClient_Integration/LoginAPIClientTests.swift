//
//  LoginAPIClientTests.swift
//  WhatsVassTests
//
//  Created by Adrian Iraizos Mendoza on 7/5/24.
//

import XCTest
import Combine

@testable import WhatsVass
final class LoginAPIClientTests: XCTestCase {
    var sut: LoginAPIClient!
    var subscribers: Set<AnyCancellable>!
    

    override func setUpWithError() throws {
        sut = LoginAPIClient()
        subscribers = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        sut = nil
        subscribers = nil
    }

    func testLoginByAPI_ShouldBetester102() {
        let expectation = XCTestExpectation(description: "Carga de loginByAPI")
        let token = "Token Mock"
        let nick = "Tester Mock"
        
        sut.loginByAPI(with: credentials)
            .sink { completion in
                switchCompletion(completion, expectation)
            } receiveValue: { response in
                XCTAssertEqual(response.token,token)
                XCTAssertEqual(response.user.nick, nick)
            }
            .store(in: &subscribers)
        
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed)
    }
    
    func testBiometricLogin_ShouldBe() {
        let expectation = XCTestExpectation(description: "Carga de biometricLogin")
        let token = "Token Mock"
        let nick = "Tester Mock"
        sut.biometricLogin(params: params)
            .sink { completion in
                switchCompletion(completion, expectation)
            } receiveValue: { response in
                XCTAssertEqual(response.token,token)
                XCTAssertEqual(response.user.nick,nick)
            }
            .store(in: &subscribers)
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed)
    }
}



