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
    case line
    case circle
    case growLine
    case growCircle
}

extension LiquidLoader {
    
    @objc public convenience init(frame: CGRect, effect: ObjCEffect, color: UIColor, numberOfCircle: Int, duration: CGFloat, growColor: UIColor? = UIColor.red) {
        var s: Effect
        
        if effect == .line {
            s = Effect.line(color, numberOfCircle, duration, growColor)
        } else if effect == .circle {
            s = Effect.circle(color, numberOfCircle, duration, growColor)
        } else if effect == .growLine {
            s = Effect.growLine(color, numberOfCircle, duration, growColor)
        } else { //if effect == .GrowCircle {
            s = Effect.growCircle(color, numberOfCircle, duration, growColor)
        }
        
        self.init(frame: frame, effect: s)
    }
    
}
