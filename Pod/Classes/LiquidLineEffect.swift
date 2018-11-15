//
//  LiquidLineLoader.swift
//  LiquidLoading
//
//  Created by Takuma Yoshida on 2015/08/21.
//  Copyright (c) 2015年 yoavlt. All rights reserved.
//

import Foundation
import UIKit

class LiquidLineEffect : LiquidLoadEffect {

    let NumberOfCircles = 5
    var circleInter: CGFloat!

    override func setupShape() -> [LiquittableCircle] {
        let array = Array(0..<NumberOfCircles)
        let circles: [LiquittableCircle] = array.map { i -> LiquittableCircle in
            let diameter: CGFloat = circleRadius * 2
            let x: CGFloat = (diameter + circleInter) * 2 + circleInter + circleRadius
            let y: CGFloat = loader.frame.height * 0.5
            let circle = LiquittableCircle(center: CGPoint(x:x, y:y), radius: circleRadius, color: color)
            return circle
        }
        return circles
    }

    override func movePosition(key: CGFloat) -> CGPoint {
        if loader != nil {
            return CGPoint(
                x: loader.frame.width * sineTransform(key: key),
                y: loader.frame.height * 0.5
            )
        } else {
            return CGPoint.zero
        }
    }

    func sineTransform(key: CGFloat) -> CGFloat {
        return sin(key * CGFloat.pi) * 0.5 + 0.5
    }

    override func update() {
        switch key {
        case 0.0...2.0:
            key += 0.01
        default:
            key = 0.0
        }
    }
    
    override func willSetup() {
        if circleRadius == nil {
            circleRadius = loader.frame.width * 0.05
        }
        self.circleInter = (loader.frame.width - 2 * circleRadius * 5) / 6
        self.engine = SimpleCircleLiquidEngine(radiusThresh: self.circleRadius, angleThresh: 0.2)
        let moveCircleRadius = circleRadius * moveScale
        self.moveCircle = LiquittableCircle(center: CGPoint(x: 0, y: loader.frame.height * 0.5), radius: moveCircleRadius, color: color)
    }
    
    override func resize() {
        let _ = circles.compactMap { circle -> (LiquittableCircle, CGFloat) in
            return (circle, circle.center.minus(point: self.moveCircle!.center).length())
            }.each { (circle, distance) in
                let normalized = 1.0 - distance / (self.circleRadius + self.circleInter)
                if normalized > 0.0 {
                    circle.radius = self.circleRadius + (self.circleRadius * self.circleScale - self.circleRadius) * normalized
                } else {
                    circle.radius = self.circleRadius
                }
        }
    }
}
