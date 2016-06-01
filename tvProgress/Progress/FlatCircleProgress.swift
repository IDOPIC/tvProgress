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
    
    private let rectShape = CAShapeLayer()
    
    //MARK: - Methods
    
    required init() {
    }
    
    func configureWithStyle(style: tvProgressStyle) -> (view: UIView, completion: () -> Void) {
        let v: UIView = UIView(frame: CGRectMake(0, 0, 100, 100))
        let bounds: CGRect = v.frame
        self.rectShape.bounds = bounds
        self.rectShape.position = v.center
        self.rectShape.cornerRadius = bounds.width / 2
        v.layer.addSublayer(self.rectShape)
        
        self.rectShape.path = UIBezierPath(ovalInRect: self.rectShape.bounds).CGPath
        self.rectShape.lineWidth = 7.0
        self.rectShape.strokeColor = style.mainColor.CGColor
        self.rectShape.fillColor = UIColor.clearColor().CGColor
        self.rectShape.strokeStart = 0
        self.rectShape.strokeEnd = 0
        
        let completion: () -> Void = { () -> Void in
            self.rectShape.removeAllAnimations()
        }
        return (v, completion)
    }
    
    func update(progress: Float) -> Void {
        let start = CABasicAnimation(keyPath: "strokeEnd")
        start.toValue = progress
        start.beginTime = 0
        start.duration = 0.25
        
        rectShape.addAnimation(start, forKey: nil)
    }
}