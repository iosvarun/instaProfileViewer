//
//  AppStoryboard.swift
//  DirectMessage
//
//  Created by Varun Kumar on 22/12/20.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// this class variable is used to return the storyboard ID
    class var storyboardID: String {
        return "\(self)"
    }
    
    /// this function is used to instantiate the storyboard
    ///
    /// - Parameter appStoryboard: storyboard name
    /// - Returns: returns the storyboard
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self? {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}

enum AppStoryboard: String {
    
    case Main
    case Splash
    case DirectMessage
    
    fileprivate var instanse: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    /// T refers to the generic argument, T.Type means Data type of T.
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T? {
        let storyBoardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instanse.instantiateViewController(withIdentifier: storyBoardID) as? T
    }
}
