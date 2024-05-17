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

    func testLoginByAPI_ShouldBetester102() async throws {
        let token = "Token Mock"
        let nick = "Tester Mock"
        
        let response = try await sut.loginByAPI(with: credentials)
        XCTAssertEqual(response.token,token)
        XCTAssertEqual(response.user.nick, nick)
    }
    
    func testBiometricLogin_ShouldBe() async throws {
        let token = "Token Mock"
        let nick = "Tester Mock"
        let response = try await sut.biometricLogin(params: params)
        XCTAssertEqual(response.token,token)
        XCTAssertEqual(response.user.nick,nick)
    }
}



