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
    
    func configureWithStyle(_ style: tvProgressStyle) -> (view: UIView, completion: () -> Void) {
        let v: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 200))
        self.sweebiLogo.bounds = v.bounds
        self.sweebiLogo.position = v.center
        self.sweebiLogo.lineWidth = 11
        self.sweebiLogo.strokeColor = style.mainColor.cgColor
        self.sweebiLogo.fillColor = UIColor.clear.cgColor
        self.sweebiLogo.strokeStart = 0
        self.sweebiLogo.strokeEnd = 0
        
        let bezier: UIBezierPath = UIBezierPath()
        bezier.move(to: CGPoint(x: 90, y: 56))
        bezier.addLine(to: CGPoint(x: 90, y: 0))
        bezier.addLine(to: CGPoint(x: 10, y: 0))
        bezier.addLine(to: CGPoint(x: 10, y: 80))
        bezier.addLine(to: CGPoint(x: 136, y: 80))
        bezier.addLine(to: CGPoint(x: 136, y: 160))
        bezier.addLine(to: CGPoint(x: 56, y: 160))
        bezier.addLine(to: CGPoint(x: 56, y: 104))
        
        self.sweebiLogo.path = bezier.cgPath
        v.layer.addSublayer(self.sweebiLogo)
        
        let completion: () -> Void = { () -> Void in
            self.sweebiLogo.removeAllAnimations()
        }
        
        return (v, completion)
    }
    
    func updateProgress(_ progress: Double) {
        let anim: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        anim.toValue = progress
        anim.beginTime = 0
        anim.duration = 0.25
        anim.fillMode = kCAFillModeForwards
        anim.isRemovedOnCompletion = false
        
        self.sweebiLogo.add(anim, forKey: nil)
    }
}
