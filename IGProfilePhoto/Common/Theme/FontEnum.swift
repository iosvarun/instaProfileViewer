//
//  FontEnum.swift
//  CallRecoder
//
//  Created by Varun Kumar on 04/09/20.
//  Copyright © 2020 Varun Kumar. All rights reserved.
//

import Foundation
import UIKit

// swiftlint:disable identifier_name
public enum FontType: String {
    case None = ""
    case Regular = "Regular"
    case Bold = "Bold"
    case DemiBold = "DemiBold"
    case Light = "Light"
    case UltraLight = "UltraLight"
    case Italic = "Italic"
    case Thin = "Thin"
    case Book = "Book"
    case Roman = "Roman"
    case Medium = "Medium"
    case MediumItalic = "MediumItalic"
    case CondensedMedium = "CondensedMedium"
    case CondensedExtraBold = "CondensedExtraBold"
    case SemiBold = "SemiBold"
    case BoldItalic = "BoldItalic"
    case LightItalic = "LightIt"
    case RegularItalic = "RegularIt"
    case Heavy = "Heavy"
    case BlackCond = "BlackCond"

}

public enum FontName: String {
    case Lato
    case OpenSans
    case SFProDisplay
    case HelveticaNeue
}

public enum FontSize: CGFloat {
    case MicroSmall = 9
    case ultraSmall = 10
    case normalSmall = 12
    case ExSmall = 13
    case Small = 14
    case JumboSmall = 15
    case Regular = 16
    case RegularJumbo = 17
    case Large = 18
    case Larger = 20
    case ExLarge = 24
    case Huge = 26
    case ExHuge = 28
    case JumboNormal = 30
    case Jumbo = 34
    case ExtraJumbo = 36
    case ExtraLargeJumbo = 40

}
