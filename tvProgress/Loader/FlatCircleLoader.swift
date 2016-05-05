//
//  FlatCircleLoader.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation

class FlatCircleLoader: tvLoaderAnimatable {
    //MARK: - Life Cycle
    required init() {
    }
    
    func configureWithStyle(style: tvProgressStyle) -> UIView {
        let v: UIView = UIView()
        
        let bounds = v.frame
        let rectShape = CAShapeLayer()
        rectShape.bounds = bounds
        rectShape.position = v.center
        rectShape.cornerRadius = bounds.width / 2
        v.layer.addSublayer(rectShape)
        
        rectShape.path = UIBezierPath(ovalInRect: rectShape.bounds).CGPath
        rectShape.lineWidth = 7.0
        rectShape.strokeColor = style.mainColor.CGColor
        rectShape.fillColor = UIColor.clearColor().CGColor
        rectShape.strokeStart = 0
        rectShape.strokeEnd = 1
        
        let start = CABasicAnimation(keyPath: "strokeStart")
        start.toValue = 1
        start.beginTime = 0
        start.duration = 1
        
        let an: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        an.fromValue = 0
        an.toValue = 1
        an.beginTime = 1
        an.duration = 1
        
        let group = CAAnimationGroup()
        group.animations = [start, an]
        group.duration = 2
        group.autoreverses = false
        group.repeatCount = HUGE
        
        rectShape.addAnimation(group, forKey: nil)
        
        return v
    }
}