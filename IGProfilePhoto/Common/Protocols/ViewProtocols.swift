//
//  ViewProtocols.swift
//  DirectMessage
//
//  Created by Varun Kumar on 22/12/20.
//

import Foundation
import UIKit

protocol ViewFromNib {}

extension ViewFromNib where Self: UIView {
    
    static var nibName : String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        let uinib = UINib(nibName: Self.nibName, bundle: nil)
        return uinib
    }
    
    static var firstView: UIView {
        return Bundle.main.loadNibNamed(Self.nibName, owner: nil, options: nil)?.first as! UIView
    }
}

extension ViewFromNib {

    static var nibName: String {
        return String(describing: Self.self)
    }

    static var nib: UINib {
        return UINib(nibName: self.nibName, bundle: nil)
    }

    static func view() -> Self? {
        let objects = self.nib.instantiate(withOwner: nil, options: nil)
        return objects.first as? Self
    }
    
    static func viewController<T: UIViewController>() -> T? {
        return T(nibName: nibName, bundle: nil)
    }
}

protocol ViewControllerFromNib: ViewFromNib {}

extension ViewControllerFromNib {
    static func viewController<T: UIViewController>() -> T? {
        return T(nibName: nibName, bundle: nil)
    }
}

protocol ViewControllerFromStoryboard {
    static var storyboardName: String { get }
}

extension ViewControllerFromStoryboard {
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: self.storyboardName, bundle: nil)
    }

    static func viewController() -> Self {
        return storyboard.instantiateViewController(withIdentifier: String(describing: Self.self)) as! Self
    }
}
