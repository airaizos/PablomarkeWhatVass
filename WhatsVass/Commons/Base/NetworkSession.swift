//
//  Network.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 25/4/24.
//

import Foundation


class NetworkSession {
    var monitor: NetworkMonitor
    let endpoints: URLPointsProtocol
    let session: URLSession
    let decoder: JSONDecoder
    
    private var isReachable: Bool
    
    init(monitor: NetworkMonitor = NetworkMonitor(), endpoints: URLPointsProtocol = Endpoints(), session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.monitor = monitor
        self.isReachable = monitor.isActive
        self.endpoints = endpoints
        self.session = session
        self.decoder = decoder
    }
    
    func requestJSON<JSON:Codable>(request: URLRequest, parameters:[String:Any]? = nil, type: JSON.Type) async throws -> JSON {
        let (data, response) =  try await session.data(for: request)
        guard let response = response as? HTTPURLResponse else { throw BaseError.notAuthorized }
        switch response.statusCode == 200 {
        case true:
            do {
                return try decoder.decode(JSON.self, from: data)
            } catch let error {
                throw BaseError.generic //BADJSON
            }
        case false: throw BaseError.notAuthorized
            
        }
    }
    
    
}


enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}


extension URLRequest {
    static func get(url: URL, token: String? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.timeoutInterval = 30
        request.httpMethod = HTTPMethods.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        if let token {
            request.setValue("Beared \(token)", forHTTPHeaderField: "Authorization")
        }
        
        return request
        
    }
    
}
