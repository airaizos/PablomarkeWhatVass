//
//  DataManagersTests.swift
//  WhatsVassTests
//
//  Created by Adrian Iraizos Mendoza on 8/5/24.
//

import XCTest
import Combine

@testable import WhatsVass
final class LoginDataManagersTests: XCTestCase {
    var api: LoginAPIClient!
    var sut: LoginDataManager!
    var subscribers: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        api = LoginAPIClient(urlProtocol: URLSessionMock.self)
        sut = LoginDataManager(apiClient: api)
        subscribers = Set<AnyCancellable>()
    }
    
    override func tearDownWithError() throws {
        api = nil
        sut = nil
        subscribers = nil
    }
    
    func testLoginWithCredentials_ShouldBeTokenMock() {
        let expectation = XCTestExpectation(description: "Carga de LoginWithCredentials-Mock")
        sut.login(with: credentials)
            .sink { completion in
                switchCompletion(completion, expectation)
            } receiveValue: { response in
                XCTAssertEqual(response.token,"Token Mock")
                XCTAssertEqual(response.user.nick,"Tester Mock")
            }
            .store(in: &subscribers)
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed)
    }
    
    func testLoginWithBiometrics_ShouldBeTockenMock() {
        let expectation = XCTestExpectation(description: "Carga deLoginWithBiometrics")
        sut.loginWithBiometric(params: params)
            .sink { completion in
                switchCompletion(completion, expectation)
            } receiveValue: { response in
                XCTAssertEqual(response.token, "Token Mock")
                XCTAssertEqual(response.user.nick, "Tester Mock")
            }
            .store(in: &subscribers)
        
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed)
    }
    
}
