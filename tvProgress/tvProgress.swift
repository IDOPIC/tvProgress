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
                    instance._blurView?.removeFromSuperview()
                    instance.removeEventCatch()
                    instance.menuButtonDidPress = .None
                    instance.playPauseButtonDidPress = .None
                    instance._finishLoaderCompletion?()
                    instance._finishLoaderCompletion = .None
                    instance.removeFromSuperview()
                    instance._isVisible = false
                    
                    instance.frame = (UIApplication.sharedApplication().keyWindow?.subviews.last)!.frame
                }
            }
        }
    }
    
    //MARK: - Build anc Config Tools
    internal static func displayDurationForString(string: String) -> Double {
        return max(Double(string.characters.count) * 0.06 + 0.5, tvProgress.sharedInstance.minimumDismissDuration)
    }
    
    internal static func showWithInstance(instance: tvProgress, andContent contentView: UIView? = .None, andViews views: [UIView] = [], andStyle style: tvProgressStyle? = .None, withBlurView addBlurView: Bool = true, menuButtonDidPress: (() -> Void)?, playButtonDidPress: (() -> Void)?) -> Void {
        if !instance._isVisible {
            instance._isVisible = true
            instance.menuButtonDidPress = menuButtonDidPress
            instance.playPauseButtonDidPress = playButtonDidPress
            instance.setEventCatch()
            
            let refParentView: UIView = contentView ?? (UIApplication.sharedApplication().keyWindow?.subviews.last)!
            instance.frame = refParentView.bounds
            if addBlurView {
                let blurEffect: UIBlurEffect = UIBlurEffect(style: (style ?? instance.style).blurStyle)
                instance._blurView = UIVisualEffectView(frame: refParentView.bounds)
                instance._blurView?.effect = blurEffect
                instance.userInteractionEnabled = true
                instance.addSubview(instance._blurView!)
            }
            
            for view: UIView in views {
                instance.addSubview(view)
            }
            
            instance.alpha = 0
            refParentView.addSubview(instance)
            UIView.animateWithDuration(instance.fadeInAnimationDuration, animations: {
                instance.alpha = 1
                }, completion: { (finished) in
                    refParentView.setNeedsFocusUpdate()
                    refParentView.updateFocusIfNeeded()
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
