//
//  tvProgressDefaultLoader.swift
//  tvProgress
//
//  Created by Antoine Cormery on 04/05/2016.
//  Copyright © 2016 Antoine Cormery. All rights reserved.
//

import UIKit

class tvProgressDefaultLoader: tvProgressLoaderProtocol {
    
    func getLoader() -> UIView {
        let view: UIView = UIView(frame: CGRectMake(0, 0, 100, 100))
        
        let bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = bounds
        rectShape.position = view.center
        rectShape.cornerRadius = bounds.width / 2
        view.layer.addSublayer(rectShape)
        
        rectShape.path = UIBezierPath(ovalInRect: rectShape.bounds).CGPath
        
        rectShape.lineWidth = 7.0
        rectShape.strokeColor = UIColor.whiteColor().CGColor
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
        
        return view
    }
}
