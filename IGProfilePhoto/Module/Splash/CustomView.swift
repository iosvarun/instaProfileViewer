//
//  CustomView.swift
//  DirectMessage
//
//  Created by Varun Kumar on 11/03/21.
//

import UIKit

class CustomView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        // Get Height and Width
        let layerHeight = layer.frame.height
        let layerWidth = layer.frame.width
        // Create Path
        let bezierPath = UIBezierPath()
        //  Points
        let pointA = CGPoint(x: 0, y: 80)
        let pointB = CGPoint(x: layerWidth, y: 0)
        let pointC = CGPoint(x: layerWidth, y: layerHeight - 80)
        let pointD = CGPoint(x: 0, y: layerHeight)

//        let pointD = CGPoint(x: 0, y: layerHeight*2/3)
        // Draw the path
        bezierPath.move(to: pointA)
        bezierPath.addLine(to: pointB)
        bezierPath.addLine(to: pointC)
        bezierPath.addLine(to: pointD)
        bezierPath.close()
        // Mask to Path
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        layer.mask = shapeLayer
    }

}
