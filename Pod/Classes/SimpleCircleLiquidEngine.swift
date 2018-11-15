//
//  SimpleCircleLiquidEngine.swift
//  LiquidLoading
//
//  Created by Takuma Yoshida on 2015/08/19.
//  Copyright (c) 2015年 yoavlt. All rights reserved.
//

import Foundation
import UIKit

/**
 * This class is so fast, but allowed only same color.
 */
class SimpleCircleLiquidEngine {

    let radiusThresh: CGFloat
    private var layer: CALayer = CAShapeLayer()

    var color = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)

    let ConnectThresh: CGFloat = 0.3
    var angleThresh: CGFloat = 0.5
    
    init(radiusThresh: CGFloat, angleThresh: CGFloat) {
        self.radiusThresh = radiusThresh
        self.angleThresh = angleThresh
    }

    func push(circle: LiquittableCircle, other: LiquittableCircle) -> [LiquittableCircle] {
        if let paths = generateConnectedPath(circle: circle, other: other) {
            let layers = paths.map(self.constructLayer)
            layers.each(f: layer.addSublayer)
            return [circle, other]
        }
        return []
    }
    
    func draw(parent: UIView) {
        parent.layer.addSublayer(layer)
    }

    func clear() {
        layer.removeFromSuperlayer()
        layer.sublayers?.each{ $0.removeFromSuperlayer() }
        layer = CAShapeLayer()
    }

    func constructLayer(path: UIBezierPath) -> CALayer {
        let pathBounds = path.cgPath.boundingBox;

        let shape = CAShapeLayer()
        shape.fillColor = self.color.cgColor
        shape.path = path.cgPath
        shape.frame = CGRect(x: 0, y: 0, width: pathBounds.width, height: pathBounds.height)
        
        return shape
    }
    
    private func circleConnectedPoint(circle: LiquittableCircle, other: LiquittableCircle, angle: CGFloat) -> (CGPoint, CGPoint) {
        let vec = other.center.minus(point: circle.center)
        let radian = atan2(vec.y, vec.x)
        let p1 = circle.circlePoint(rad: radian + angle)
        let p2 = circle.circlePoint(rad: radian - angle)
        return (p1, p2)
    }
    
    private func circleConnectedPoint(circle: LiquittableCircle, other: LiquittableCircle) -> (CGPoint, CGPoint) {
        var ratio = circleRatio(circle: circle, other: other)
        ratio = (ratio + ConnectThresh) / (1.0 + ConnectThresh)
        let angle = CGFloat.pi / 2.0 * ratio
        return circleConnectedPoint(circle: circle, other: other, angle: angle)
    }

    private func generateConnectedPath(circle: LiquittableCircle, other: LiquittableCircle) -> [UIBezierPath]? {
        if isConnected(circle: circle, other: other) {
            let ratio = circleRatio(circle: circle, other: other)
            switch ratio {
            case angleThresh...1.0:
                if let path = normalPath(circle: circle, other: other) {
                    return [path]
                }
                return nil
            case 0.0..<angleThresh:
                return splitPath(circle: circle, other: other, ratio: ratio)
            default:
                return nil
            }
        } else {
            return nil
        }
    }

    private func normalPath(circle: LiquittableCircle, other: LiquittableCircle) -> UIBezierPath? {
        let (p1, p2) = circleConnectedPoint(circle: circle, other: other)
        let (p3, p4) = circleConnectedPoint(circle: other, other: circle)
        if let crossed = CGPoint.intersection(from: p1, to: p3, from2: p2, to2: p4) {
            return withBezier { path in
                let r = self.circleRatio(circle: circle, other: other)
                path.move(to: p1)
                let mul = p1.plus(point: p4).div(rhs: 2).split(point: crossed, ratio: r * 1.25 - 0.25)
                path.addQuadCurve(to: p4, controlPoint: mul)
                path.addLine(to: p3)
                let mul2 = p2.plus(point: p3).div(rhs: 2).split(point: crossed, ratio: r * 1.25 - 0.25)
                path.addQuadCurve(to: p2, controlPoint: mul2)
            }
        }
        return nil
    }

    private func splitPath(circle: LiquittableCircle, other: LiquittableCircle, ratio: CGFloat) -> [UIBezierPath] {
        let (p1, p2) = circleConnectedPoint(circle: circle, other: other, angle: CGMath.degToRad(deg: 40))
        let (p3, p4) = circleConnectedPoint(circle: other, other: circle, angle: CGMath.degToRad(deg: 40))

        if let crossed = CGPoint.intersection(from: p1, to: p3, from2: p2, to2: p4) {
            let (d1, _) = self.circleConnectedPoint(circle: circle, other: other, angle: 0)
            let (d2, _) = self.circleConnectedPoint(circle: other, other: circle, angle: 0)
            let r = (ratio - ConnectThresh) / (angleThresh - ConnectThresh)

            let a1 = d1.split(point: crossed.mid(point: d2), ratio: 1 - r)
            let part = withBezier { path in
                path.move(to: p1)
                let _ = a1.split(point: p1, ratio: ratio)
                let _ = a1.split(point: p2, ratio: ratio)
                path.addQuadCurve(to: p2, controlPoint: a1)
            }
            let a2 = d2.split(point: crossed.mid(point: d1), ratio: 1 - r)
            let part2 = withBezier { path in
                path.move(to: p3)
                let _ = a2.split(point: p3, ratio: ratio)
                let _ = a2.split(point: p4, ratio: ratio)
                path.addQuadCurve(to: p4, controlPoint: a2)
            }
            return [part, part2]
        }
        return []
    }

    private func circleRatio(circle: LiquittableCircle, other: LiquittableCircle) -> CGFloat {
        let distance = other.center.minus(point: circle.center).length()
        let ratio = 1.0 - (distance - radiusThresh) / (circle.radius + other.radius + radiusThresh)
        return min(max(ratio, 0.0), 1.0)
    }

    func isConnected(circle: LiquittableCircle, other: LiquittableCircle) -> Bool {
        let distance = circle.center.minus(point: other.center).length()
        return distance - circle.radius - other.radius < radiusThresh
    }

}
