//
//  UIColorExtensions.swift
//  CallRecoder
//
//  Created by Varun Kumar on 04/09/20.
//  Copyright © 2020 Varun Kumar. All rights reserved.
//

import Foundation

import UIKit

extension UIColor {
    
   
    ///init method with RGB values from 0 to 255, instead of 0 to 1. With alpha(default:1)
     public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
         self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
     }

     ///init method with hex string and alpha(default: 1)
     public convenience init?(hexString: String, alpha: CGFloat = 1.0) {
         var formatted = hexString.replacingOccurrences(of: "0x", with: "")
         formatted = formatted.replacingOccurrences(of: "#", with: "")
         if let hex = Int(formatted, radix: 16) {
             let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16)/255.0)
             let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8)/255.0)
             let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0)/255.0)
             self.init(red: red, green: green, blue: blue, alpha: alpha)
         } else {
             return nil
         }
     }
    
    ///init method with hex value
    public convenience init(hex: UInt64, alpha: CGFloat = 1.0) {
        let r = CGFloat((hex >> 16) & 0xff)
        let g = CGFloat((hex >> 8) & 0xff)
        let b = CGFloat(hex & 0xff)
        
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: alpha)
    }
    
    ///init method with hex value
    public convenience init(hex: UInt64) {
        let r = CGFloat((hex >> 16) & 0xff)
        let g = CGFloat((hex >> 8) & 0xff)
        let b = CGFloat(hex & 0xff)
        
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: 1)
    }
    
    ///init method with hex string
    public convenience init?(hexString: String) {
        guard hexString.count == 6 else {
            return nil
        }
        
        let scanner = Scanner(string: hexString)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        self.init(hex: rgbValue)
    }
    
    ///method to adjust the brightness
    private func adjustBrightness(_ percentage: CGFloat) -> UIColor {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        if getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            b = min(b * percentage, 1)
            return UIColor(hue: h, saturation: s, brightness: b, alpha: a)
        }
        
        return self
    }
    
    ///method to set light brightness
    func lighten() -> UIColor {
        return adjustBrightness(1.5)
    }
    
    ///method to set dark brightness
    func darken() -> UIColor {
        return adjustBrightness(0.8)
    }
}

