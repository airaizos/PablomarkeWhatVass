//
//  SettingsAPIClient.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 14/3/24.
//

import Foundation
import Combine

final class SettingsAPIClient: BaseAPIClient {
    func logout() -> AnyPublisher <LogOutResponse, BaseError> {
        requestPublisher(url: EndpointsUsers.urlLogout, type: LogOutResponse.self)
    }
}
