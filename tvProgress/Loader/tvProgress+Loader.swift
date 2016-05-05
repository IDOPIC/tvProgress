//
//  tvProgress+Loader.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation

extension tvProgress {
    //MARK: - Properties
    public var loaderType: tvLoaderType! {
        get {
            return self.loaderType ?? .Default()
        }
        set(newLoader) {
            self.loaderType = newLoader ?? .Default()
        }
    }
    
    //MARK: - Methods
    static func show(status: String? = .None, loaderType: tvLoaderType? = .None, style: tvProgressStyle? = nil) -> Void {
        let instance: tvProgress = tvProgress.sharedInstance
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            if !instance._isVisible {
                instance._isVisible = true
                
                let loaderView: UIView = (loaderType ?? instance.loaderType).getInstance(style ?? instance.style) ?? UIView(frame: CGRectZero)
                loaderView.frame = CGRectMake(instance.center.x - (loaderView.frame.width / 2), instance.center.y - (loaderView.frame.height / 2), loaderView.frame.width, loaderView.frame.height)
                instance.addSubview(loaderView)
                
                if (status != .None) {
                    let statusLabel: UILabel = UILabel()
                    statusLabel.text = status
                    statusLabel.numberOfLines = 0
                    statusLabel.font = instance.font
                    statusLabel.backgroundColor = UIColor.clearColor()
                    
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