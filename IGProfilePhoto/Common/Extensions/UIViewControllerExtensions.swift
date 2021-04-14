//
//  UIViewControllerExtensions.swift
//  DirectMessage
//
//  Created by Varun Kumar on 22/12/20.
//

import Foundation
import UIKit

extension UIViewController {
    func addChildViewController(_ viewController: UIViewController, inView view: UIView) {
        addChild(viewController)
        viewController.view.frame = view.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    func remove(asChildViewController viewController: UIViewController?) {
        // Notify Child View Controller
        viewController?.willMove(toParent: nil)
        // Remove Child View From Superview
        viewController?.view.removeFromSuperview()
        // Notify Child View Controller
        viewController?.removeFromParent()
    }
    
}
