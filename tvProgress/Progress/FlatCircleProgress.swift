//
//  FlatCircleProgress.swift
//  tvProgress
//
//  Created by Antoine Cormery on 01/06/16.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation

class FlatCircleProgress: tvProgressAnimatable {
    
    //MARK: - Properties
    
    fileprivate let rectShape = CAShapeLayer()
    
    //MARK: - Methods
    
    required init() {
    }
    
    func configureWithStyle(_ style: tvProgressStyle) -> (view: UIView, completion: () -> Void) {
        let v: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let bounds: CGRect = v.frame
        self.rectShape.bounds = bounds
        self.rectShape.position = v.center
        self.rectShape.cornerRadius = bounds.width / 2
        v.layer.addSublayer(self.rectShape)
        
        self.rectShape.path = UIBezierPath(ovalIn: self.rectShape.bounds).cgPath
        self.rectShape.lineWidth = 7.0
        self.rectShape.strokeColor = style.mainColor.cgColor
        self.rectShape.fillColor = UIColor.clear.cgColor
        self.rectShape.strokeStart = 0
        self.rectShape.strokeEnd = 0
        
        let completion: () -> Void = { () -> Void in
            self.rectShape.removeAllAnimations()
        }
        return (v, completion)
    }
    
    func updateProgress(_ progress: Double) -> Void {
        let anim: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        anim.toValue = progress
        anim.beginTime = 0
        anim.duration = 0.25
        anim.fillMode = kCAFillModeForwards
        anim.isRemovedOnCompletion = false
        
        rectShape.add(anim, forKey: nil)
    }
}
