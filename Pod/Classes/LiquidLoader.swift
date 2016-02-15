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
    case Line(UIColor, UIColor?, Int, CGFloat)
    case Circle(UIColor, UIColor?, Int, CGFloat)
    case GrowLine(UIColor, UIColor?, Int, CGFloat)
    case GrowCircle(UIColor, UIColor?, Int, CGFloat)
    
    func setup(loader: LiquidLoader) -> LiquidLoadEffect {
        switch self {
        case .Line(let color, let growColor, let count, let duration):
            return LiquidLineEffect(loader: loader, color: color, growColor: growColor, circleCount: count, duration: duration)
        case .Circle(let color, let growColor, let count, let duration):
            return LiquidCircleEffect(loader: loader, color: color, growColor: growColor, circleCount: count, duration: duration)
        case .GrowLine(let color, let growColor, let count, let duration):
            let line = LiquidLineEffect(loader: loader, color: color, growColor: growColor, circleCount: count, duration: duration)
            line.isGrow = true
            return line
        case .GrowCircle(let color, let growColor,let count, let duration):
            let circle = LiquidCircleEffect(loader: loader, color: color, growColor: growColor, circleCount: count, duration: duration)
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
        self.effectDelegate = self.effect.setup(self)
    }

    public required init?(coder aDecoder: NSCoder) {
        self.effect = .Circle(UIColor.whiteColor(), UIColor.redColor(), 5, 3.0)
        super.init(coder: aDecoder)
        self.effectDelegate = self.effect.setup(self)
    }

    public func show() {
        self.hidden = false
    }

    public func hide() {
        self.hidden = true
    }
    
    override public func didMoveToWindow() {
        super.didMoveToWindow()
        if(self.window == nil) {
            // we were removed.. lets stop everything
            effectDelegate?.stopTimer()
        }
    }
}