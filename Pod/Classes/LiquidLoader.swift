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
    case Line(UIColor)
    case Circle(UIColor)
    case GrowLine(UIColor)
    case GrowCircle(UIColor)
    
    func setup(loader: LiquidLoader) -> LiquidLoadEffect {
        switch self {
        case .Line(let color):
            return LiquidLineEffect(loader: loader, color: color)
        case .Circle(let color):
            return LiquidCircleEffect(loader: loader, color: color)
        case .GrowLine(let color):
            let line = LiquidLineEffect(loader: loader, color: color)
            line.isGrow = true
            return line
        case .GrowCircle(let color):
            let circle = LiquidCircleEffect(loader: loader, color: color)
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

    public required init(coder aDecoder: NSCoder) {
        self.effect = .Circle(UIColor.whiteColor())
        super.init(coder: aDecoder)
        self.effectDelegate = self.effect.setup(self)
    }

    public func show() {
        self.hidden = false
    }

    public func hide() {
        self.hidden = true
    }
}