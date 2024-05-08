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
        let credentials = ["password": "password",
                           "login": "username",
                           "platform": "ios",
                           "firebaseToken": "fgjñdjsfgdfj"]
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwMSIsImlhdCI6MTcxNTA3MjMxMywiZXhwIjoxNzE3NjY0MzEzfQ.b8KfgPABLui3-t745jHz-ggYV9BN7WLgRs5wEhdWazA"
        let nick = "tester102"
        
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
        let params = ["Authorization": "token"]
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJuaWNrIjoiTmFtZSBDb2RlIiwidXNlcklkIjoiMTIzNDU2Nzg5MCIsIm9ubGluZSI6dHJ1ZSwiaWF0IjoxNTE2MjM5MDIyfQ.Dg45lkJH8Km23gnKlP6U8T9sgpFG3mUo9k7tADGnq"
        let nick = "Nombre Código"
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



