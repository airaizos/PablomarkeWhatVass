//
//  BaseAPIClient.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 6/3/24.
//

import Foundation
import Combine
//import Alamofire

class BaseAPIClient {
    
    private var isReachable: Bool = true
 //   private var sesionManager: Alamofire.Session!
    private var baseURL: URL = Base.baseURL
    
    var urlProtocol: URLProtocol.Type?
        
    private var session: URLSession {
        if let urlProtocol {
            let configuration = URLSessionConfiguration.ephemeral
            configuration.protocolClasses = [urlProtocol]
            return URLSession(configuration: configuration)
        } else {
            return URLSession.shared
        }
    }
    
    init(urlProtocol: URLProtocol.Type? = nil) {
   //     self.sesionManager = Session()
        startListenerReachability()
        self.urlProtocol = urlProtocol
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
    
//    func requestPublisher<T: Decodable>(relativePath: String?,
//                                        method: HTTPMethod = .get,
//                                        parameters: Parameters? = nil,
//                                        urlEncoding: ParameterEncoding = JSONEncoding.default,
//                                        type: T.Type = T.self,
//                                        base: URL? = URL(string: Base.mock),
//                                        customHeaders: HTTPHeaders? = nil) -> AnyPublisher<T, BaseError> {
//        
//        guard let url = base, let path = relativePath else {
//            return Fail(error: .failedURL).eraseToAnyPublisher()
//        }
//        
//        guard let urlAbsolute = url.appendingPathComponent(path).absoluteString.removingPercentEncoding else {
//            return Fail(error: .noURl).eraseToAnyPublisher()
//        }
//        
//        var headers = HTTPHeaders()
//        if !((UserDefaults.standard.string(forKey: Preferences.token)?.isEmpty) == nil) {
//            guard let token = UserDefaults.standard.string(forKey: Preferences.token) else {
//                return Fail(error: .noToken).eraseToAnyPublisher()
//            }
//            headers.add(name: "Authorization",
//                        value: token)
//        }
//        
//        return sesionManager.request(urlAbsolute,
//                                     method: method,
//                                     parameters: parameters,
//                                     encoding: urlEncoding,
//                                     headers: headers)
//        .validate()
//#if DEBUG
//        .cURLDescription(on: .main, calling: { _ in })
//#endif
//        .publishDecodable(type: T.self, emptyResponseCodes: [204])
//        .tryMap({ response in
//            // print(String(decoding: response.data!, as: UTF8.self))
//            switch response.result {
//            case let .success(result):
//                return result
//            case let .failure(error):
//                //   print(String(decoding: response.data!,
//                //               as: UTF8.self))
//                //  print(response.data)
//                print("-----------base-----------\(error)")
//                throw error
//            }
//        })
//        .mapError({ [weak self] error in
//            guard let self = self else { return .generic }
//            return self.handler(error: error) ?? .generic
//        })
//        .eraseToAnyPublisher()
//    }
    
    func requestPublisher<T: Codable>(url: URL,
                                      method: HTTPMethods = .get,
                                      type: T.Type) -> AnyPublisher<T, BaseError> {
        
        guard let token = getToken() else {
            return Fail(error: .noToken).eraseToAnyPublisher()
        }
        
        let request = URLRequest.get(url: url, token: token)
        
        return session.dataTaskPublisher(for: request)
            .tryMap({ result in
                return try JSONDecoder().decode(T.self, from: result.data)
            })
            .mapError({ [weak self] error in
                guard let self = self else { return .generic }
                return self.handler(error: error) ?? .generic
            })
            .eraseToAnyPublisher()
    }
    
    func requestPostPublisher<T: Codable, U:Codable>(url: URL,
                                          data: T) -> AnyPublisher<U, BaseError> {
        guard let token = getToken() else {
            return Fail(error: .noToken).eraseToAnyPublisher()
        }
        
        let request = URLRequest.post(url: url, data: data,token: token)
        
        return session.dataTaskPublisher(for: request)
            .tryMap({ result in
                return try JSONDecoder().decode(U.self, from: result.data)
            })
            .mapError({ [weak self] error in
                guard let self = self else { return .generic }
                return self.handler(error: error) ?? .generic
            })
            .eraseToAnyPublisher()
    }
    
    // MARK: - Private Method
    private func startListenerReachability() {
        let monitor = NetworkMonitor()
        self.isReachable = monitor.isActive
//        net?.startListening(onUpdatePerforming: { _ in
//            self.isReachable = net?.isReachable ?? false
//        })
    }
    
    private func getToken() -> String? {
        //TODO: Cambiar a Keychain
        if !((UserDefaults.standard.string(forKey: Preferences.token)?.isEmpty) == nil) {
            guard let token = UserDefaults.standard.string(forKey: Preferences.token) else {
                return nil
            }
            return token
        }
        return nil
    }
}



