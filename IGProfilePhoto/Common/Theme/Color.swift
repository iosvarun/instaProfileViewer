//
//  Color.swift
//  CallRecoder
//
//  Created by Varun Kumar on 04/09/20.
//  Copyright © 2020 Varun Kumar. All rights reserved.
//

import Foundation
import UIKit

struct Color {
    static let clearColor = UIColor.clear
    static let whiteColor = UIColor.white
    static let blackColor = UIColor.init(hex: 0x000000)
    static let greenColor = UIColor.init(hex: 0x259164)
    static let lightGray = UIColor.init(hex: 0xF2F4F7)
    static let lightBlackColor = UIColor.init(hex: 0x333333)
    static let lightGray1 = UIColor(hex: 0xF5F5F5)
    static let lightGray2 = UIColor(hex: 0x999999)
    static let dimLightGray = UIColor(hex: 0xF3F3F3)
    static let lightGreen = UIColor(hex: 0xD7EAD6)
    static let lightBlue = UIColor(hex: 0xD6DFEA)
    static let pagingControlGreen = UIColor(hex: 0xBFEDDA)
    static let redColor = UIColor(hex: 0xC62E2E)
    static let dashBorderColor = UIColor(hex: 0xE4E7EB)
  }

enum ColorCustomization {
    case clearColor
    case whiteColor
    case blackColor
    case appThemeColor
    case viewBgColor
    case textColor
    case lightBgColor
    case cellBgColor
    case shadowColor
    case lightBlue
    case lightGreen
    case pagingGreen
    case inAppPro
    case dashBorder
}
