//
//  LoginAPIClient.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 5/3/24.
//

import Foundation
import Alamofire
import Combine

final class LoginAPIClient: BaseAPIClient {
    func loginByAPI(with credentials: [String: Any]) -> AnyPublisher <LoginResponse, BaseError> {

        return requestPublisher(relativePath: EndpointsUsers.login,
                                method: .post,
                                parameters: credentials)
    }

    func biometricLogin(params: [String: Any]) -> AnyPublisher <LoginResponse, BaseError> {

        return requestPublisher(relativePath: EndpointsUsers.biometric,
                                method: .post,
                                parameters: params)
    }
}
