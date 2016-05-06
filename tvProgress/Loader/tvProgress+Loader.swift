//
//  tvProgress+Loader.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation

public extension tvProgress {
    //MARK: - Properties
    public var loaderType: tvLoaderType! {
        get {
            return self._loaderType ?? .Default()
        }
        set(newLoader) {
            self._loaderType = newLoader ?? .Default()
        }
    }
    
    //MARK: - Methods
    public static func show(status: String? = .None,loaderType lt: tvLoaderType? = .None, style: tvProgressStyle? = nil) -> Void {
        let instance: tvProgress = tvProgress.sharedInstance
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            if !instance._isVisible {
                instance._isVisible = true
                
                let blurEffect: UIBlurEffect = UIBlurEffect(style: (style ?? instance.style).blurStyle)
                instance._blurView?.effect = blurEffect
                
                let loader: (view: UIView, completion: () -> Void) = (lt ?? instance.loaderType).getInstance(style ?? instance.style)
                let loaderView: UIView = loader.0
                loaderView.frame = CGRectMake(instance.center.x - (loaderView.frame.width / 2), instance.center.y - (loaderView.frame.height / 2), loaderView.frame.width, loaderView.frame.height)
                instance.addSubview(loaderView)
                instance.finishLoaderCompletion = loader.completion
                
                if (status != .None) {
                    let statusLabel: UILabel = UILabel()
                    statusLabel.text = status
                    statusLabel.numberOfLines = 0
                    statusLabel.font = instance.font
                    statusLabel.backgroundColor = UIColor.clearColor()
                    statusLabel.textColor = (style ?? tvProgressStyle.Light).mainColor
                    
                    statusLabel.sizeToFit()
                    statusLabel.frame = CGRectMake(instance.center.x - (statusLabel.frame.width / 2), loaderView.frame.origin.y + loaderView.frame.height + 30, statusLabel.frame.width, statusLabel.frame.height)
                    
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