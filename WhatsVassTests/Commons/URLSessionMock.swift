//
//  URLSessionMock.swift
//  WhatsVassTests
//
//  Created by Adrian Iraizos Mendoza on 8/5/24.
//

import Foundation

@testable import WhatsVass
final class URLSessionMock: URLProtocol {
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        if let url = request.url {
            switch url.lastPathComponent {
            case "login",
                EndpointsUsers.biometric: getMockData(from: URLJsonLocator.login)
            case "getContacts": getMockData(from: URLJsonLocator.users)
                
            case "list": getMockData(from: URLJsonLocator.chatsList)
            case EndpointsChats.createChat: getMockData(from: URLJsonLocator.createChat)
                
            case "messages": getMockData(from: URLJsonLocator.messages)
            case "chatMessages": getMockData(from: URLJsonLocator.getMessages)
                
            case "profile": getMockData(from: URLJsonLocator.registerProfile)
            case EndpointsMessages.newMessage,
                EndpointsChats.chats : getMockData(from: URLJsonLocator.response)
                
            case EndpointsUsers.logOut: getMockData(from: URLJsonLocator.logout)
            default: break
            }
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
    
    
    func getMockData(from url: URL) {
        if let data = try? Data(contentsOf: url) {
            client?.urlProtocol(self, didLoad: data)
            if let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json"]) {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
        }
    }
}



struct URLJsonLocator {
    static let login: URL = Bundle.getJsonURL("loginResponse")
    static let users: URL = Bundle.getJsonURL("getContacts")
    static let chatsList: URL = Bundle.getJsonURL("ChatList")
    static let createChat: URL = Bundle.getJsonURL("createChat")
    static let messages: URL = Bundle.getJsonURL("messages")
    static let getMessages: URL = Bundle.getJsonURL("getChats")
    static let response: URL = Bundle.getJsonURL("response")
    static let registerProfile: URL = Bundle.getJsonURL("createAndRegisterProfile")
    static let logout: URL = Bundle.getJsonURL("logoutResponse")
}

extension Bundle {
    static func getJsonURL(_ file: String, inBundle: AnyObject.Type = LoginDataManagersTests.self) -> URL {
        Bundle(for: inBundle).url(forResource: file, withExtension: "json")!
    }
}
