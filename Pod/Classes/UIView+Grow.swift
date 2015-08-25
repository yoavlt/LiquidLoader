//
//  UIView+Grow.swift
//  LiquidLoading
//
//  Created by Takuma Yoshida on 2015/08/24.
//  Copyright (c) 2015年 yoavlt. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func grow(baseColor: UIColor, radius: CGFloat, shininess: CGFloat) {
        let growColor = UIColor(red: 0 / 255.0, green: 1, blue: 1, alpha: 1.0)
        growShadow(radius, growColor: growColor, shininess: shininess)
        let circle = CAShapeLayer()
        circle.path = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: radius * 2.0, height: radius * 2.0)).CGPath
        let circleGradient = CircularGradientLayer(colors: [growColor, UIColor(white: 1.0, alpha: 0)])
        circleGradient.frame = CGRect(x: 0, y: 0, width: radius * 2.0, height: radius * 2.0)
        circleGradient.opacity = 0.25
        for sub in layer.sublayers {
            if let l = sub as? CAShapeLayer {
                l.fillColor = UIColor.clearColor().CGColor
            }
        }
        circleGradient.mask = circle
        layer.addSublayer(circleGradient)
    }
    
    func growShadow(radius: CGFloat, growColor: UIColor, shininess: CGFloat) {
        let origin = self.center.minus(self.frame.origin).minus(CGPoint(x: radius * shininess, y: radius * shininess))
        let ovalRect = CGRect(origin: origin, size: CGSize(width: 2 * radius * shininess, height: 2 * radius * shininess))
        let shadowPath = UIBezierPath(ovalInRect: ovalRect)
        self.layer.shadowColor = growColor.CGColor
        self.layer.shadowRadius = radius
        self.layer.shadowPath = shadowPath.CGPath
        self.layer.shadowOpacity = 1.0
        self.layer.shouldRasterize = true
        self.layer.shadowOffset = CGSizeZero
        self.layer.masksToBounds = false
        self.clipsToBounds = false
    }
}