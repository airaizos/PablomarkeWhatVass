//
//  UIViewControllerExtensions.swift
//  WhatsVass
//
//  Created by Adrian Iraizos Mendoza on 14/5/24.
//

import SwiftUI

extension UIViewController {
    func setHostingControllerView<V: View>(_ view: UIView, hostingController: UIHostingController<V>) {
         addChild(hostingController)
         view.addSubview(hostingController.view)
         hostingController.view.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
             hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
         ])
         hostingController.didMove(toParent: self)
     }
}
