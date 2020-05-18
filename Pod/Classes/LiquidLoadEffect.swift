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
    var color = UIColor.white
    var growColor = UIColor.red
    
    var engine: SimpleCircleLiquidEngine?
    var moveCircle: LiquittableCircle?
    var shadowCircle: LiquittableCircle?
    
    var isAnimation: Bool {
        return timer != nil
    }
    
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

    init(loader: LiquidLoader, color: UIColor, circleCount: Int, duration: CGFloat, growColor: UIColor? = UIColor.red) {
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
    }
    
    func updateKeyframe(_ key: CGFloat) {
        self.engine?.clear()
        let movePos = movePosition(key)
        
        // move subviews positions
        moveCircle?.center = movePos
        shadowCircle?.center = movePos
        circles.each { circle in
            if self.moveCircle != nil {
                _ = self.engine?.push(self.moveCircle!, other: circle)
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

    func movePosition(_ key: CGFloat) -> CGPoint {
        return CGPoint.zero // abstract
    }

    @objc func update() {
        // abstract
    }
    
    func willSetup() {
        // abstract
    }
    
    func grow(_ isGrow: Bool) {
        if isGrow {
            shadowCircle = LiquittableCircle(center: self.moveCircle!.center, radius: self.moveCircle!.radius * 1.0, color: self.color, growColor: growColor)
            shadowCircle?.isGrow = isGrow
            loader?.addSubview(shadowCircle!)
        } else {
            shadowCircle?.removeFromSuperview()
        }
    }
    
    func startTimer() {
        guard timer == nil else { return }
        timer = CADisplayLink(target: self, selector: #selector(LiquidLoadEffect.update))
        timer?.add(to: RunLoop.main, forMode: RunLoop.Mode.common)
    }

    func stopTimer() {
        guard timer != nil else { return }
        timer?.invalidate()
        timer = nil
    }
}
