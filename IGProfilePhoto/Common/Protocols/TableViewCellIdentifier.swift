//
//  TableViewCellIdentifiable.swift
//  IGProfilePhoto
//
//  Created by Varun Kumar on 10/04/21.
//

import Foundation

import UIKit

protocol ReuseIdentifier {
    static var resuseIdentifier: String { get }
}

extension ReuseIdentifier where Self: UITableViewCell {
   
    static var resuseIdentifier: String {
        return String(describing: self)
    }
}
