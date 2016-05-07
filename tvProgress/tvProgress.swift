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
    internal var finishLoaderCompletion: (() -> Void)?
    
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
                    instance.finishLoaderCompletion?()
                    instance.finishLoaderCompletion = nil
                    instance.removeFromSuperview()
                    instance._isVisible = false
                }
            }
        }
    }
    
    internal static func displayDurationForString(string: String) -> Double {
        return max(Double(string.characters.count) * 0.06 + 0.5, tvProgress.sharedInstance.minimumDismissDuration)
    }
    
    internal static func showWithStatus(status: String? = .None, view v: UIView? = .None, style: tvProgressStyle? = .None) -> Void {
        let instance: tvProgress = tvProgress.sharedInstance
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            if !instance._isVisible {
                instance._isVisible = true
                
                let blurEffect: UIBlurEffect = UIBlurEffect(style: (style ?? instance.style).blurStyle)
                instance._blurView?.effect = blurEffect
                
                if let hudView = v {
                    instance.addSubview(hudView)
                }
                
                if (status != .None) {
                    let statusLabel: UILabel = UILabel()
                    statusLabel.text = status
                    statusLabel.numberOfLines = 0
                    statusLabel.font = instance.font
                    statusLabel.backgroundColor = UIColor.clearColor()
                    statusLabel.textColor = (style ?? tvProgressStyle.Light).mainColor
                    statusLabel.sizeToFit()
                    var frame: CGRect!
                    if let hudView = v {
                        frame = CGRectMake(instance.center.x - (statusLabel.frame.width / 2), hudView.frame.origin.y + hudView.frame.height + 30, statusLabel.frame.width, statusLabel.frame.height)
                    } else {
                        frame = CGRectMake(instance.center.x - statusLabel.frame.size.width / 2, instance.center.y - statusLabel.frame.size.height / 2, statusLabel.frame.size.width, statusLabel.frame.size.height)
                    }
                    
                    statusLabel.frame = frame
                    instance.addSubview(statusLabel)
                }
                
                let tabWindow: [UIWindow] = UIApplication.sharedApplication().windows
                for w in tabWindow {
                    if (w.screen == UIScreen.mainScreen() && !w.hidden && w.alpha > 0 && w.windowLevel == UIWindowLevelNormal) {
                        instance.alpha = 0
                        w.addSubview(instance)
                        
                        UIView.animateWithDuration(instance.fadeInAnimationDuration) { () -> Void in
                            instance.alpha = 1
                        }
                        break;
                    }
                }
            }
        }
    }
}
