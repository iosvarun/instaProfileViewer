//
//  AlertViewProtocol.swift
//  DirectMessage
//
//  Created by Varun Kumar on 22/12/20.
//

import Foundation
import UIKit

protocol AlertViewProtocol {
    func showAlert(_ title: String?, message: String?, actions: [UIAlertAction])
}

extension AlertViewProtocol where Self: UIViewController {
    func showAlert(_ title: String?, message: String?, actions: [UIAlertAction]) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        _ = actions.compactMap { action -> UIAlertAction in
            controller.addAction(action)
            return action
        }
        self.present(controller, animated: true, completion: nil)
    }
}

extension UIViewController: AlertViewProtocol {}
