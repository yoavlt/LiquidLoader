//
//  LiquidLoader.swift
//  LiquidLoading
//
//  Created by Takuma Yoshida on 2015/08/17.
//  Copyright (c) 2015年 yoavlt. All rights reserved.
//

import Foundation
import UIKit

class LiquidLoadEffect : NSObject {

    var numberOfCircles: Int
    var duration: CGFloat
    var circleScale: CGFloat = 1.17
    var moveScale: CGFloat = 0.80
    var color = UIColor.whiteColor()
    var growColor = UIColor.redColor()

    var engine: SimpleCircleLiquidEngine?
    var moveCircle: LiquittableCircle?
    var shadowCircle: LiquittableCircle?
    
    var timer:  CADisplayLink?

    weak var loader: LiquidLoader!
    
    var isGrow = false {
        didSet {
            grow(self.isGrow)
        }
    }

    /* the following properties is initialized when frame is assigned */
    var circles: [LiquittableCircle]!
    var circleRadius: CGFloat!
    
    var key: CGFloat = 0.0 {
        didSet {
            updateKeyframe(self.key)
        }
    }

    init(loader: LiquidLoader, color: UIColor, circleCount: Int, duration: CGFloat, growColor: UIColor? = UIColor.redColor()) {
        self.numberOfCircles = circleCount
        self.duration = duration
        self.circleRadius = loader.frame.width * 0.05
        self.loader = loader
        self.color = color
        if growColor != nil {
            self.growColor = growColor!
        }
        super.init()
        setup()
    }

    func resize() {
        // abstract
    }

    func setup() {
        willSetup()
        
        engine?.color = color

        self.circles = setupShape()
        for circle in circles {
            loader?.addSubview(circle)
        }
        if moveCircle != nil {
            loader?.addSubview(moveCircle!)
        }
        resize()

        timer = CADisplayLink(target: self, selector: "update")
        timer?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    func updateKeyframe(key: CGFloat) {
        self.engine?.clear()
        let movePos = movePosition(key)
        
        // move subviews positions
        moveCircle?.center = movePos
        shadowCircle?.center = movePos
        circles.each { circle in
            if self.moveCircle != nil {
                self.engine?.push(self.moveCircle!, other: circle)
            }
        }
        
        resize()

        // draw and show grow
        if let parent = loader {
            self.engine?.draw(parent)
        }
        if let shadow = shadowCircle {
            loader?.bringSubviewToFront(shadow)
        }
    }

    func setupShape() -> [LiquittableCircle] {
        return [] // abstract
    }

    func movePosition(key: CGFloat) -> CGPoint {
        return CGPointZero // abstract
    }

    func update() {
        // abstract
    }
    
    func willSetup() {
        // abstract
    }
    
    func grow(isGrow: Bool) {
        if isGrow {
            shadowCircle = LiquittableCircle(center: self.moveCircle!.center, radius: self.moveCircle!.radius * 1.0, color: self.color, growColor: growColor)
            shadowCircle?.isGrow = isGrow
            loader?.addSubview(shadowCircle!)
        } else {
            shadowCircle?.removeFromSuperview()
        }
    }

    func stopTimer() {
        timer?.invalidate()
    }
}