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

    override func draw(in ctx: CGContext) {
        var locations = CGMath.linSpace(from: 0.0, to: 1.0, n: colors.count)
        locations = locations.map { 1.0 - $0 * $0 }.reversed()
        let cgColors = colors.map { $0.cgColor } as CFArray
        if let gradients = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: cgColors, locations: locations) {
            ctx.drawRadialGradient(gradients, startCenter: self.frame.center, startRadius: CGFloat(0.0), endCenter: self.frame.center, endRadius: max(self.frame.width, self.frame.height), options: CGGradientDrawingOptions(rawValue: 10))
        }
    }
}
