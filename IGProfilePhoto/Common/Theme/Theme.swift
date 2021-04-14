//
//  Theme.swift
//  CallRecoder
//
//  Created by Varun Kumar on 04/09/20.
//  Copyright © 2020 Varun Kumar. All rights reserved.
//

import Foundation

import UIKit

class Theme {

    struct Font {
        static func light(_ size: CGFloat) -> UIFont {
            return UIFont.displayFont(type: .Light, size: size)
        }

        static func regular(_ size: CGFloat) -> UIFont {
            return UIFont.displayFont(type: .Regular, size: size)
        }

        static func medium(_ size: CGFloat) -> UIFont {
            return UIFont.displayFont(type: .Medium, size: size)
        }
        static func semiBold(_ size: CGFloat) -> UIFont {
            return UIFont.displayFont(type: .SemiBold, size: size)
        }

        static func bold(_ size: CGFloat) -> UIFont {
            return UIFont.displayFont(type: .Bold, size: size)
        }

        static func lightItalic(_ size: CGFloat) -> UIFont {
            return UIFont.displayFont(type: .LightItalic, size: size)
        }

        static func regularItalic(_ size: CGFloat) -> UIFont {
            return UIFont.displayFont(type: .RegularItalic, size: size)
        }

        static func boldItalic(_ size: CGFloat) -> UIFont {
            return UIFont.displayFont(type: .BoldItalic, size: size)
        }
        
        static func blackCond(_ size: CGFloat) -> UIFont {
            return UIFont.displayFont(type: .BlackCond, size: size)
        }
        
    }
    
    static func color(_ customization: ColorCustomization) -> UIColor {
        return colorBase(customization)
    }
    
    static func colorBase(_ customization: ColorCustomization) -> UIColor {
        switch customization {
        case.whiteColor: return Color.whiteColor
        case.clearColor: return Color.clearColor
        case.blackColor: return Color.blackColor
        case.viewBgColor: return Color.lightGray
        case.appThemeColor: return Color.greenColor
        case.textColor: return Color.lightBlackColor
        case.lightBgColor: return Color.lightGray2
        case.cellBgColor: return Color.lightGray1
        case.shadowColor: return Color.dimLightGray
        case.lightGreen: return Color.lightGreen
        case.lightBlue: return Color.lightBlue
        case.pagingGreen: return Color.pagingControlGreen
        case.inAppPro: return Color.redColor
        case.dashBorder: return Color.dashBorderColor
        }
    }
    
}
