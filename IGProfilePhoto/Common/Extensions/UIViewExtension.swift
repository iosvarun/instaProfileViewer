//
//  UIViewExtension.swift
//  DirectMessage
//
//  Created by Varun Kumar on 22/12/20.
//

import Foundation

import UIKit


extension UIView {
    func containView(_ view: UIView) {
        view.frame = self.bounds
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        
        let views = ["subview": view]
        let vconstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|", options: [], metrics: nil, views: views)
        let hconstraints = NSLayoutConstraint.constraints(withVisualFormat: "|-0-[subview]-0-|", options: [], metrics: nil, views: views)
        self.addConstraints(vconstraints)
        self.addConstraints(hconstraints)
    }
    
    func cornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = CGFloat(radius)
        layer.masksToBounds = true
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
    }
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor(hex: 0x0000000F).cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: -1, height: 2)
        layer.shadowRadius = 1
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func addDashedBorder() {
        let color = Theme.color(ColorCustomization.dashBorder).cgColor
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 6).cgPath
        self.layer.addSublayer(shapeLayer)
    }
 
}
