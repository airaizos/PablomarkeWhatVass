//
//  SettingsAPIClient.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 14/3/24.
//

import Foundation
import Combine
import Alamofire

final class SettingsAPIClient: BaseAPIClient {
    func logout() -> AnyPublisher <LogOutResponse, BaseError> {
        let url: String = EndpointsUsers.logOut
        return requestPublisher(relativePath: url,
                                method: .post)
    }
}
