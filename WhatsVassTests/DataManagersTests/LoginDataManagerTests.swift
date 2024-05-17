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
    
    func testLoginWithCredentials_ShouldBeTokenMock() async throws {
        let response = try await sut.login(with: credentials)
        XCTAssertEqual(response.token,"Token Mock")
        XCTAssertEqual(response.user.nick,"Tester Mock")
    }
    
    func testLoginWithBiometrics_ShouldBeTockenMock() async throws{
        let response = try await sut.loginWithBiometric(params: params)
        XCTAssertEqual(response.token, "Token Mock")
        XCTAssertEqual(response.user.nick, "Tester Mock")
    }
}
