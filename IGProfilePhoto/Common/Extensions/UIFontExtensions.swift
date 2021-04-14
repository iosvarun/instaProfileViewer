//
//  UIFontExtensions.swift
//  CallRecoder
//
//  Created by Varun Kumar on 04/09/20.
//  Copyright © 2020 Varun Kumar. All rights reserved.
//

import Foundation

import UIKit

extension UIFont {

    public class func font(_ name: FontName, type: FontType, size: CGFloat) -> UIFont! {
        //Using type
        let fontName = name.rawValue + "-" + type.rawValue
        if let font = UIFont(name: fontName, size: size) {
            return font
        }

        //That font doens't have that type, try .None
        let fontNameNone = name.rawValue
        if let font = UIFont(name: fontNameNone, size: size) {
            return font
        }
 
        //That font doens't have that type, try .Regular
        let fontNameRegular = name.rawValue + "-" + "Regular"
        if let font = UIFont(name: fontNameRegular, size: size) {
            return font
        }

        return nil
    }
    
    public class func displayFont(type: FontType, size: CGFloat) -> UIFont {
        return font(.HelveticaNeue, type: type, size: size )
    }
    
    public class func latoDisplayFont(type: FontType, size: CGFloat) -> UIFont {
           return font(.Lato, type: type, size: size )
    }
    
}
