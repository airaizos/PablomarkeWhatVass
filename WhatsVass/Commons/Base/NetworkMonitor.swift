//
//  NetworkMonitor.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 25/4/24.
//

import Foundation
import Network


final class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")
    var collectedData:(String,Bool) = ("",false)

    
    /// ¿Tenemos acceso a internet?
    var isActive = false
    
    /// Es internet móvil o un punto de acceso personal?
    var isExpensive = false
    
    /// Está en Modo de datos reducidos
    var isConstrained = false
    
    var connectionType = NWInterface.InterfaceType.other
    
    /// Stops monitoring
    var isMonitorActive = true
    
    /// ¿Hay wifi?
    var isWiFiAvailable = false
    
    init() {
    //    NWConnection(message: .default)
        
        monitor.pathUpdateHandler = .some({ newPath in
            self.isActive = newPath.status == .satisfied
            self.isExpensive = newPath.isExpensive
            self.isConstrained = newPath.isConstrained
            
            let connectionTypes: [NWInterface.InterfaceType] = [.cellular,.wifi, .wiredEthernet,.loopback]
            self.connectionType = connectionTypes.first(where: newPath.usesInterfaceType) ?? .other
            
            //Solo entra una vez
            self.isWiFiAvailable  = self.connectionType == .wifi ? true : false

            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        })
        monitor.start(queue: queue)
    }
    
    /// Waiting for access
    func makeRequest(_ completion: @escaping ((String, Bool) -> Void)) {
        let config = URLSessionConfiguration.default
        config.allowsExpensiveNetworkAccess = false
        config.allowsConstrainedNetworkAccess = false
        config.waitsForConnectivity = true
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        let session = URLSession(configuration: config)
        let url = URL(string: "https://www.proximaparadaswift.dev")!
        
        session.dataTask(with: url) { data, _, _ in
            
            if let data = data {
                completion(data.description, false)
            }
        }.resume()
    }
    
    func stopMonitor(_ completion: @escaping ((Bool) -> Void)) {
        monitor.cancel()
        isMonitorActive = false
        completion(isMonitorActive)
        
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
}
