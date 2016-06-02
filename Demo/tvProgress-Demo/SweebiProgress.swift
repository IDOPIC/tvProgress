//
//  SweebiProgress.swift
//  tvProgress-Demo
//
//  Created by Antoine Cormery on 02/06/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation
import tvProgress

class SweebiProgress: tvProgressAnimatable {
    
    let sweebiLogo: CAShapeLayer = CAShapeLayer()
    
    required init() {
    }
    
    func configureWithStyle(style: tvProgressStyle) -> (view: UIView, completion: () -> Void) {
        let v: UIView = UIView(frame: CGRectMake(0, 0, 150, 200))
        self.sweebiLogo.bounds = v.bounds
        self.sweebiLogo.position = v.center
        self.sweebiLogo.lineWidth = 11
        self.sweebiLogo.strokeColor = style.mainColor.CGColor
        self.sweebiLogo.fillColor = UIColor.clearColor().CGColor
        self.sweebiLogo.strokeStart = 0
        self.sweebiLogo.strokeEnd = 0
        
        let bezier: UIBezierPath = UIBezierPath()
        bezier.moveToPoint(CGPoint(x: 90, y: 56))
        bezier.addLineToPoint(CGPoint(x: 90, y: 0))
        bezier.addLineToPoint(CGPoint(x: 10, y: 0))
        bezier.addLineToPoint(CGPoint(x: 10, y: 80))
        bezier.addLineToPoint(CGPoint(x: 136, y: 80))
        bezier.addLineToPoint(CGPoint(x: 136, y: 160))
        bezier.addLineToPoint(CGPoint(x: 56, y: 160))
        bezier.addLineToPoint(CGPoint(x: 56, y: 104))
        
        self.sweebiLogo.path = bezier.CGPath
        v.layer.addSublayer(self.sweebiLogo)
        
        let completion: () -> Void = { () -> Void in
            self.sweebiLogo.removeAllAnimations()
        }
        
        return (v, completion)
    }
    
    func updateProgress(progress: Double) {
        let anim: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        anim.toValue = progress
        anim.beginTime = 0
        anim.duration = 0.25
        anim.fillMode = kCAFillModeForwards
        anim.removedOnCompletion = false
        
        self.sweebiLogo.addAnimation(anim, forKey: nil)
    }
}