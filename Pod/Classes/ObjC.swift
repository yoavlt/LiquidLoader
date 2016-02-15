//
//  ObjC.swift
//  test
//
//  Created by Prasanga Siripala on 9/25/15.
//  Copyright © 2015 PJ Engineering and Business Solutions Pty. Ltd. All rights reserved.
//

import Foundation
import UIKit

@objc public enum ObjCEffect: Int {
    case Line
    case Circle
    case GrowLine
    case GrowCircle
}

extension LiquidLoader {
    
    @objc public convenience init(frame: CGRect, effect: ObjCEffect, color: UIColor, numberOfCircle: Int, duration: CGFloat) {
        var s: Effect
        
        if effect == .Line {
            s = Effect.Line(color, numberOfCircle, duration)
        } else if effect == .Circle {
            s = Effect.Circle(color, numberOfCircle, duration)
        } else if effect == .GrowLine {
            s = Effect.GrowLine(color, numberOfCircle, duration)
        } else { //if effect == .GrowCircle {
            s = Effect.GrowCircle(color, numberOfCircle, duration)
        }
        
        self.init(frame: frame, effect: s)
    }
    
}