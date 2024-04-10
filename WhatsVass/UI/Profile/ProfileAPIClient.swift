//
//  ProfileAPIClient.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 7/3/24.
//

import Foundation
import Combine
import Alamofire

final class ProfileAPIClient: BaseAPIClient {
    func createAndRegisterProfileInAPI(params: [String: Any]) -> AnyPublisher <UserResponse, BaseError> {

        return requestPublisher(relativePath: EndpointsUsers.register,
                                method: .post,
                                parameters: params,
                                urlEncoding: JSONEncoding.default,
                                type: UserResponse.self)
    }
}
