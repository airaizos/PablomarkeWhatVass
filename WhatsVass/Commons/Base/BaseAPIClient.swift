//
//  BaseAPIClient.swift
//  WhatsVass
//
//  Created by Pablo Marquez Marin on 6/3/24.
//

import Foundation

class BaseAPIClient {
    
    private var isReachable: Bool = true
    //   private var sesionManager: Alamofire.Session!
    private var baseURL: URL = Base.baseURL
    
    var urlProtocol: URLProtocol.Type?
    var persistence: LocalPersistence
    private var session: URLSession {
        if let urlProtocol {
            let configuration = URLSessionConfiguration.ephemeral
            configuration.protocolClasses = [urlProtocol]
            return URLSession(configuration: configuration)
        } else {
            return URLSession.shared
        }
    }
    
    init(urlProtocol: URLProtocol.Type? = nil, persistence: LocalPersistence = .shared) {
        self.urlProtocol = urlProtocol
        self.persistence = persistence
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

    func fetchCodable<T: Codable>(url: URL,
                                  method: HTTPMethods = .get,
                                  type: T.Type) async throws -> T {
        
        guard let token = getToken() else {
            throw BaseError.noToken
        }
        
        let request = URLRequest.get(url: url, token: token)
        
        let (data,response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw BaseError.noURl
        }
        if response.statusCode == 200 {
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw BaseError.noCodable
            }
        } else {
            throw BaseError.status(response.statusCode)
        }
    }
    
    func postCodable<T: Codable, U:Codable>(url: URL,
                                            data: T) async throws -> U {
        guard let token = getToken() else {
            throw BaseError.noToken
        }
        
        //let request = URLRequest.post(url: url, data: data, token: token)
        let request = URLRequest.post(url: url, data: data)
        let (data,response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw BaseError.noURl
        }
        if response.statusCode == 200 {
            do {
                return try JSONDecoder().decode(U.self, from: data)
            } catch {
                throw BaseError.noCodable
            }
        } else {
            throw BaseError.status(response.statusCode)
        }
    }
    
    // MARK: - Private Method
    private func startListenerReachability() {
        let monitor = NetworkMonitor()
        self.isReachable = monitor.isActive
    }
    //FIXME: Este da error
    private func getToken() -> String? {
        //TODO: Cambiar a Keychain
        guard let token = persistence.getString(forKey: .token) else {
            return "Mirar este token"
        }
        return token
    }
}



func generateRandomAlphabetLetter() -> String {
    let letters = "abcdefghijklmnopqrstuvwxyz"
    let randomIndex = Int(arc4random_uniform(UInt32(letters.count)))
    let randomLetter = letters[letters.index(letters.startIndex, offsetBy: randomIndex)]
    return String(randomLetter)
}
