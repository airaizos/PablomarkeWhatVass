//
//  BaseAPIClient.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 6/3/24.
//

import Foundation
import Combine
import Alamofire

class BaseAPIClient {

    private var isReachable: Bool = true
    private var sesionManager: Alamofire.Session!
    private var baseURL: URL {

        if let url = URL(string: Base.mockMovilidad) {
            return url
        } else {
            return URL(string: "")!
        }
    }

    init() {
        self.sesionManager = Session()
        startListenerReachability()
    }

    // MARK: - Public method
    func handler(error: Error?) -> BaseError? {

        if !self.isReachable { return .noInternetConnection }
        var baseError: BaseError?

        if error != nil {
            baseError = .handler
        }

        return baseError
    }

    func requestPublisher<T: Decodable>(relativePath: String?,
                                        method: HTTPMethod = .get,
                                        parameters: Parameters? = nil,
                                        urlEncoding: ParameterEncoding = JSONEncoding.default,
                                        type: T.Type = T.self,
                                        base: URL? = URL(string: Base.mockMovilidad),
                                        customHeaders: HTTPHeaders? = nil) -> AnyPublisher<T, BaseError> {

        guard let url = base, let path = relativePath else {
            return Fail(error: .failedURL).eraseToAnyPublisher()
        }

        guard let urlAbsolute = url.appendingPathComponent(path).absoluteString.removingPercentEncoding else {
            return Fail(error: .noURl).eraseToAnyPublisher()
        }

        var headers = HTTPHeaders()
        if !((UserDefaults.standard.string(forKey: Preferences.token)?.isEmpty) == nil) {
            guard let token = UserDefaults.standard.string(forKey: Preferences.token) else {
                return Fail(error: .noToken).eraseToAnyPublisher()
            }
           headers.add(name: "Authorization",
                        value: token)
        }

       return sesionManager.request(urlAbsolute,
                                     method: method,
                                     parameters: parameters,
                                     encoding: urlEncoding,
                                     headers: headers)
            .validate()
#if DEBUG
            .cURLDescription(on: .main, calling: { _ in })
#endif
            .publishDecodable(type: T.self, emptyResponseCodes: [204])
            .tryMap({ response in
                // print(String(decoding: response.data!, as: UTF8.self))
                switch response.result {
                case let .success(result):
                    return result
                case let .failure(error):
                    //   print(String(decoding: response.data!,
                    //               as: UTF8.self))
                  //  print(response.data)
                    print("-----------base-----------\(error)")
                    throw error
                }
            })
            .mapError({ [weak self] error in
                guard let self = self else { return .generic }
                return self.handler(error: error) ?? .generic
            })
            .eraseToAnyPublisher()
    }

    // MARK: - Private Method
    private func startListenerReachability() {

        let net = NetworkReachabilityManager()
        net?.startListening(onUpdatePerforming: { _ in
            self.isReachable = net?.isReachable ?? false
        })
    }
}
