//
//  CircularGradientLayer.swift
//  LiquidLoading
//
//  Created by Takuma Yoshida on 2015/08/21.
//  Copyright (c) 2015年 yoavlt. All rights reserved.
//

import Foundation
import UIKit

class CircularGradientLayer : CALayer {
    let colors: [UIColor]
    init(colors: [UIColor]) {
        self.colors = colors
        super.init()
        setNeedsDisplay()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawInContext(ctx: CGContext!) {
        var locations = CGMath.linSpace(0.0, to: 1.0, n: colors.count)
        locations = locations.map { 1.0 - $0 * $0 }.reverse()
        let gradients = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), colors.map { $0.CGColor }, locations)
        CGContextDrawRadialGradient(ctx, gradients, self.frame.center, CGFloat(0.0), self.frame.center, max(self.frame.width, self.frame.height), 10)
    }
}
