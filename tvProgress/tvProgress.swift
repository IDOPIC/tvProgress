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
    internal var _finishLoaderCompletion: (() -> Void)?
    internal var _menuButtonPressClosure: (() -> Void)?
    internal var _playPauseButtonPressClosure: (() -> Void)?
    
    //MARK: - Singleton
    static let sharedInstance: tvProgress = {
        let instance = tvProgress()
        
        instance.frame = UIScreen.mainScreen().bounds
        instance.alpha = 0
        let blurEffect: UIBlurEffect = UIBlurEffect(style: instance.style.blurStyle)
        instance._blurView = UIVisualEffectView(frame: instance.frame)
        instance._blurView?.effect = blurEffect
        instance.userInteractionEnabled = true
        
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
                    instance._finishLoaderCompletion?()
                    instance._finishLoaderCompletion = nil
                    instance.removeFromSuperview()
                    instance._isVisible = false
                }
            }
        }
    }
    
    //MARK: - Build anc Config Tools
    internal static func displayDurationForString(string: String) -> Double {
        return max(Double(string.characters.count) * 0.06 + 0.5, tvProgress.sharedInstance.minimumDismissDuration)
    }
    
    internal static func showWithInstance(instance: tvProgress, andViews views: [UIView] = [], andStyle style: tvProgressStyle? = .None) -> Void {
        if !instance._isVisible {
            instance._isVisible = true
            instance.setEventCatch()
            
            let blurEffect: UIBlurEffect = UIBlurEffect(style: (style ?? instance.style).blurStyle)
            instance._blurView?.effect = blurEffect
            
            for view: UIView in views {
                instance.addSubview(view)
            }
            
            instance.alpha = 0
            let tmp: UIView = (UIApplication.sharedApplication().keyWindow?.subviews.last)!
            tmp.addSubview(instance)
            UIView.animateWithDuration(instance.fadeInAnimationDuration, animations: {
                instance.alpha = 1
                }, completion: { (finished) in
                    debugPrint("completed animation")
                    tmp.setNeedsFocusUpdate()
                    tmp.updateFocusIfNeeded()
            })
        }
    }
    
    internal static func generateStatusLabelWithInstance(instance: tvProgress, andStatus status: String, andStyle style: tvProgressStyle) -> UILabel {
        let statusLabel: UILabel = UILabel()
        
        statusLabel.text = status
        statusLabel.numberOfLines = 0
        statusLabel.font = instance.font
        statusLabel.backgroundColor = UIColor.clearColor()
        statusLabel.textColor = style.mainColor
        statusLabel.sizeToFit()
        
        return statusLabel
    }
    
    //MARK: - Focus Engine
    public override func canBecomeFocused() -> Bool {
        return tvProgress.sharedInstance.isVisible
    }
    
    public override var preferredFocusedView: UIView? {
        for v in self.subviews {
            if v is UIButton {
                return v
            }
        }
        
        return self
    }
}
