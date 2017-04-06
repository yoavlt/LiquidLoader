//
//  LiquidLoader.swift
//  LiquidLoading
//
//  Created by Takuma Yoshida on 2015/08/24.
//  Copyright (c) 2015年 yoavlt. All rights reserved.
//

import Foundation
import UIKit

public enum Effect {
    case line(UIColor, Int, CGFloat, UIColor?)
    case circle(UIColor, Int, CGFloat, UIColor?)
    case growLine(UIColor, Int, CGFloat, UIColor?)
    case growCircle(UIColor, Int, CGFloat, UIColor?)
    
    func setup(loader: LiquidLoader) -> LiquidLoadEffect {
        switch self {
        case .line(let color, let count, let duration, let growColor):
            return LiquidLineEffect(loader: loader, color: color, circleCount: count, duration: duration, growColor: growColor)
        case .circle(let color, let count, let duration, let growColor):
            return LiquidCircleEffect(loader: loader, color: color, circleCount: count, duration: duration, growColor: growColor)
        case .growLine(let color, let count, let duration, let growColor):
            let line = LiquidLineEffect(loader: loader, color: color, circleCount: count, duration: duration, growColor: growColor)
            line.isGrow = true
            return line
        case .growCircle(let color,let count, let duration, let growColor):
            let circle = LiquidCircleEffect(loader: loader, color: color, circleCount: count, duration: duration, growColor: growColor)
            circle.isGrow = true
            return circle
        }
    }

}

public class LiquidLoader : UIView {
    private let effect: Effect
    private var effectDelegate: LiquidLoadEffect?

    public init(frame: CGRect, effect: Effect) {
        self.effect = effect
        super.init(frame: frame)
        self.effectDelegate = self.effect.setup(loader: self)
    }

    public required init?(coder aDecoder: NSCoder) {
        self.effect = .circle(UIColor.white, 5, 3.0, UIColor.red)
        super.init(coder: aDecoder)
        self.effectDelegate = self.effect.setup(loader: self)
    }

    public func show() {
        self.isHidden = false
    }

    public func hide() {
        self.isHidden = true
    }
    
    override public func didMoveToWindow() {
        super.didMoveToWindow()
        if(self.window == nil) {
            // we were removed.. lets stop everything
            effectDelegate?.stopTimer()
        }
    }
}
