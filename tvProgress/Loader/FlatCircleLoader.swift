//
//  FlatCircleLoader.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation

class FlatCircleLoader: UIView, tvLoaderAnimatable {
    //MARK: - Properties
    
    //MARK: - Life Cycle
    override required init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() -> Void {
        let bounds = self.frame
        let rectShape = CAShapeLayer()
        rectShape.bounds = bounds
        rectShape.position = self.center
        rectShape.cornerRadius = bounds.width / 2
        self.layer.addSublayer(rectShape)
        
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
    }
}