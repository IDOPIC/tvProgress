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
    internal var _blurView: UIVisualEffectView?
    internal var _loaderType: tvLoaderType!
    internal var _style: tvProgressStyle!
    internal var _font: UIFont!
    internal var _successImage: UIImage!
    internal var _errorImage: UIImage!
    internal var _minimumDismissDuration: Double!
    internal var _fadeInAnimationDuration: Double!
    internal var _fadeOutAnimationDuration: Double!
    internal var _isVisible: Bool = false
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
        let blurEffect: UIBlurEffect = UIBlurEffect(style: instance.style.blurStyle)
        instance._blurView = UIVisualEffectView(frame: instance.frame)
        instance._blurView?.effect = blurEffect
        
        instance.addSubview(instance._blurView!)
        
        return instance
    }()
    
    //MARK: - Methods
    public static func dismiss(delay: Double = 0) -> Void {
        let instance: tvProgress = tvProgress.sharedInstance
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            if instance._isVisible {
                UIView.animateWithDuration(instance.fadeOutAnimationDuration, delay: delay, options: .CurveEaseInOut, animations: { () -> Void in
                    instance.alpha = 0
                }) { (_) -> Void in
                    for v in instance.subviews where !(v is UIVisualEffectView){
                        v.removeFromSuperview()
                    }
                    instance.removeFromSuperview()
                    instance._isVisible = false
                }
            }
        }
    }
}
