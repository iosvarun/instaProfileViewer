//
//  AlertPresentable.swift
//  DirectMessage
//
//  Created by Varun Kumar on 14/01/21.
//

import Foundation
import UIKit

protocol AlertPresentable where Self: UIViewController {
    var alertStyle: UIAlertController.Style { get }
    var alertComponents: AlertComponents { get }
}

struct AlertComponents {
    var title: String?
    var message: String?
    var actions: [UIAlertAction]
    var completion: (() -> Void)?
    init(title: String?, message: String? = nil, actions: [AlertActionComponent], completion: (() -> Void)? = nil) {
        self.title = title
        self.message = message
        self.completion = completion
        self.actions = actions.map {
            UIAlertAction(title: $0.title, style: $0.style, handler: $0.handler)
        }
    }
}

struct AlertActionComponent {
    
    var title: String
    var style: UIAlertAction.Style
    var handler: ((UIAlertAction) -> Void)?
    init(title: String, style: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Void)?) {
        self.title = title
        self.style = style
        self.handler = handler
    }
}

extension AlertPresentable {
    var alertStyle: UIAlertController.Style {
        return .alert
    }
    
    private var alertTitle: String? {
        return alertComponents.title
    }
    private var message: String? {
        return alertComponents.message
    }
    private var actions: [UIAlertAction] {
        return alertComponents.actions
    }
    
    private var completion: (() -> Void)? {
        return alertComponents.completion
    }
    
    func presentAlert() {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: alertStyle)
        actions.forEach { alert.addAction($0) }
        present(alert, animated: true, completion: completion)
    }
}
