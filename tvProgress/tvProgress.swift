//
//  tvProgress.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import UIKit

public class tvProgress: UIView {
    //MARK: - Properties
    var _isVisible: Bool = false
    public var isVisible: Bool {
        get {
            return _isVisible
        }
    }
    
    //MARK: - Singleton
    static let sharedInstance: tvProgress = {
        let instance = tvProgress()
        
        instance.frame = UIScreen.mainScreen().bounds
        instance.alpha = 0
        
        return instance
    }()
    
    //MARK: - Methods
    static func dismiss(delay: Double = 0) -> Void {
        let instance: tvProgress = tvProgress.sharedInstance
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            if instance._isVisible {
                UIView.animateWithDuration(instance.fadeOutAnimationDuration, delay: delay, options: .CurveEaseInOut, animations: { () -> Void in
                    instance.alpha = 0
                }) { (_) -> Void in
                    for v in instance.subviews {
                        v.removeFromSuperview()
                    }
                    instance.removeFromSuperview()
                    instance._isVisible = false
                }
            }
        }
    }
}
