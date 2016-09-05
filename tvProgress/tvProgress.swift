//
//  tvProgress.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import UIKit

internal enum visibleType {
    case loader()
    case success()
    case error()
    case progress(view: tvProgressAnimatable, statusLabel: UILabel?)
}

open class tvProgress: UIView {
    //MARK: - Properties
    internal var _blurView: UIVisualEffectView?
    internal var _loaderType: tvLoaderType!
    internal var _progressType: tvProgressType!
    internal var _style: tvProgressStyle!
    internal var _font: UIFont!
    internal var _successImage: UIImage!
    internal var _errorImage: UIImage!
    internal var _minimumDismissDuration: Double!
    internal var _fadeInAnimationDuration: Double!
    internal var _fadeOutAnimationDuration: Double!
    internal var _isVisible: visibleType? = nil
    open var isVisible: Bool {
        get {
            return _isVisible != nil
        }
    }
    internal var _finishLoaderCompletion: (() -> Void)?
    internal var _menuButtonPressClosure: (() -> Void)?
    internal var _playPauseButtonPressClosure: (() -> Void)?
    
    //MARK: - Singleton
    internal static let sharedInstance: tvProgress = {
        let instance = tvProgress()
        instance.frame = UIScreen.main.bounds
        instance.alpha = 0
        return instance
    }()
    
    open static func sdismiss() -> Void {
        dismiss(0, completion: .none)
    }
    
    //MARK: - Methods
    /**
     To dismiss the loader view
     
     - Parameters:
        - delay: time before dismissing the loader
        - completion: completion block at end
     */
    open static func dismiss(_ delay: Double = 0, completion: (() -> Void)? = .none) -> Void {
        let instance: tvProgress = tvProgress.sharedInstance
        OperationQueue.main.addOperation { () -> Void in
            if instance.isVisible {
                UIView.animate(withDuration: instance.fadeOutAnimationDuration, delay: delay, options: UIViewAnimationOptions(), animations: { () -> Void in
                    instance.alpha = 0
                }) { (_) -> Void in
                    for v in instance.subviews where !(v is UIVisualEffectView) {
                        v.removeFromSuperview()
                    }
                    instance._blurView?.removeFromSuperview()
                    instance.removeEventCatch()
                    instance.menuButtonDidPress = .none
                    instance.playPauseButtonDidPress = .none
                    instance._finishLoaderCompletion?()
                    instance._finishLoaderCompletion = .none
                    instance.removeFromSuperview()
                    instance._isVisible = nil
                    
                    instance.frame = (UIApplication.shared.keyWindow?.subviews.last)!.frame
                    
                    completion?()
                }
            }
        }
    }
    
    //MARK: - Build anc Config Tools
    internal static func displayDurationForString(_ string: String) -> Double {
        return max(Double(string.characters.count) * 0.06 + 0.5, tvProgress.sharedInstance.minimumDismissDuration)
    }
    
    internal static func showWithInstance(_ instance: tvProgress, andVisibleType vt: visibleType, andContent contentView: UIView? = .none, andViews views: [UIView] = [], andStyle style: tvProgressStyle? = .none, withBlurView addBlurView: Bool = true, menuButtonDidPress: (() -> Void)? = .none, playButtonDidPress: (() -> Void)? = .none, completion: (() -> Void)? = .none) -> Void {
        guard contentView == .none || (menuButtonDidPress == nil && playButtonDidPress == nil) else {
            debugPrint("WARNING: you can't set a contentView with button completion")
            return
        }
        
        if !instance.isVisible {
            instance._isVisible = vt
            instance.menuButtonDidPress = menuButtonDidPress
            instance.playPauseButtonDidPress = playButtonDidPress
            
            if contentView == .none {
                instance.setEventCatch()
            }
            
            let refParentView: UIView = contentView ?? (UIApplication.shared.keyWindow?.subviews.last)!
            instance.frame = refParentView.bounds
            if addBlurView {
                let blurEffect: UIBlurEffect = UIBlurEffect(style: (style ?? instance.style).blurStyle)
                instance._blurView = UIVisualEffectView(frame: refParentView.bounds)
                instance._blurView?.effect = blurEffect
                instance.isUserInteractionEnabled = true
                instance.addSubview(instance._blurView!)
            }
            
            for view: UIView in views {
                instance.addSubview(view)
            }
            
            instance.alpha = 0
            refParentView.addSubview(instance)
            UIView.animate(withDuration: instance.fadeInAnimationDuration, animations: {
                instance.alpha = 1
                }, completion: { (finished) in
                    refParentView.setNeedsFocusUpdate()
                    refParentView.updateFocusIfNeeded()
                    
                    completion?()
            })
        }
    }
    
    internal static func generateStatusLabelWithInstance(_ instance: tvProgress, andStatus status: String, andStyle style: tvProgressStyle) -> UILabel {
        let statusLabel: UILabel = UILabel()
        
        statusLabel.text = status
        statusLabel.numberOfLines = 0
        statusLabel.font = instance.font
        statusLabel.backgroundColor = UIColor.clear
        statusLabel.textColor = style.mainColor
        statusLabel.sizeToFit()
        
        return statusLabel
    }
    
    //MARK: - Focus Engine
    open override var canBecomeFocused: Bool {
        get {
            return true
        }
    }
    
    open override var preferredFocusedView: UIView? {
        for v in self.subviews {
            if v is UIButton {
                return v
            }
        }
        return self
    }
}
