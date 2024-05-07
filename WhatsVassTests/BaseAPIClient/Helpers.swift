//
//  Helpers.swift
//  WhatsVassTests
//
//  Created by Adrian Iraizos Mendoza on 7/5/24.
//

import XCTest
import Combine
@testable import WhatsVass

func switchCompletion(_ completion: Subscribers.Completion<BaseError>,_ expectation: XCTestExpectation) {
    switch completion {
    case .finished:
        expectation.fulfill()
    case .failure(let error):
        XCTFail(error.description())
    }
}
