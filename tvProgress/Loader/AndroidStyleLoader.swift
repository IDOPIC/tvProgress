//
//  AndroidStyleLoader.swift
//  tvProgress
//
//  Created by Antoine Cormery on 06/05/16.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation

class AndroidStyleLoader: tvLoaderAnimatable {
    
    //MARK: - tvLoaderAnimatable
    required init(){
    }
    
    func configureWithStyle(style: tvProgressStyle) -> (view: UIView, completion: () -> Void) {
        let v: UIView = UIView(frame: CGRectMake(0, 0, 100, 100))
        
        let bounds: CGRect = v.frame
        let rectShape: CAShapeLayer = CAShapeLayer()
        rectShape.bounds = bounds
        rectShape.position = v.center
        rectShape.cornerRadius = bounds.width / 2
        v.layer.addSublayer(rectShape)
        
        rectShape.path = UIBezierPath(ovalInRect: rectShape.bounds).CGPath
        rectShape.lineWidth = 7.0
        rectShape.strokeColor = style.mainColor.CGColor
        rectShape.fillColor = UIColor.clearColor().CGColor
        rectShape.strokeStart = 0
        rectShape.strokeEnd = 0

        let firstStepStart: CABasicAnimation = CABasicAnimation(keyPath: "strokeStart")
        firstStepStart.fromValue = 0
        firstStepStart.toValue = 0.25
        firstStepStart.beginTime = 0
        firstStepStart.duration = 0.33
        
        let firstStepEnd: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        firstStepEnd.fromValue = 0
        firstStepEnd.toValue = 0.75
        firstStepEnd.beginTime = firstStepStart.beginTime
        firstStepEnd.duration = firstStepStart.duration
        
        let secondStepStart: CABasicAnimation = CABasicAnimation(keyPath: "strokeStart")
        secondStepStart.fromValue = firstStepStart.toValue
        secondStepStart.toValue = 0.40
        secondStepStart.beginTime = firstStepStart.beginTime + firstStepStart.duration
        secondStepStart.duration = 0.5
        
        let secondStepEnd: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        secondStepEnd.fromValue = firstStepEnd.toValue
        secondStepEnd.toValue = 0.90
        secondStepEnd.beginTime = secondStepStart.beginTime
        secondStepEnd.duration = secondStepStart.duration
        
        let thirdStepStart: CABasicAnimation = CABasicAnimation(keyPath: "strokeStart")
        thirdStepStart.fromValue = secondStepStart.toValue
        thirdStepStart.toValue = 1
        thirdStepStart.beginTime = secondStepStart.beginTime + secondStepStart.duration
        thirdStepStart.duration = 0.33
        
        let thirdStepEnd: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        thirdStepEnd.fromValue = secondStepEnd.toValue
        thirdStepEnd.toValue = 1
        thirdStepEnd.beginTime = thirdStepStart.beginTime
        thirdStepEnd.duration = thirdStepStart.duration
        
        let group: CAAnimationGroup = CAAnimationGroup()
        group.animations = [firstStepStart, firstStepEnd, secondStepStart, secondStepEnd, thirdStepStart, thirdStepEnd]
        group.duration = 1.50
        group.autoreverses = false
        group.repeatCount = HUGE //infinite
        
        rectShape.addAnimation(group, forKey: nil)
        
        let completion: () -> Void = { () -> Void in
            rectShape.removeAllAnimations()
        }
        
        return (v, completion)
    }
}