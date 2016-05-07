//
//  tvProgress+Success.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation

extension tvProgress {
    func showSuccessWithStatus(status: String) -> Void {
        //TODO: - Implementation
    }
    
    //MARK: - Methods
    public static func showSuccessWithStatus(status: String, successImage si: UIImage? = .None, style: tvProgressStyle? = .None) -> Void {
        let instance: tvProgress = tvProgress.sharedInstance
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            if !instance._isVisible {
                instance._isVisible = true
                
                let blurEffect: UIBlurEffect = UIBlurEffect(style: (style ?? instance.style).blurStyle)
                instance._blurView?.effect = blurEffect
                
                let successIm: UIImage = si ?? instance.successImage
                let successImageView: UIImageView = UIImageView(frame: CGRectMake(instance.center.x - successIm.size.width / 2, instance.center.y - successIm.size.height / 2, successIm.size.width, successIm.size.height))
                successImageView.image = successIm
                successImageView.tintColor = (style ?? tvProgressStyle.Light).mainColor
                instance.addSubview(successImageView)
                
                if (status != .None) {
                    let statusLabel: UILabel = UILabel()
                    statusLabel.text = status
                    statusLabel.numberOfLines = 0
                    statusLabel.font = instance.font
                    statusLabel.backgroundColor = UIColor.clearColor()
                    statusLabel.textColor = (style ?? tvProgressStyle.Light).mainColor
                    
                    statusLabel.sizeToFit()
                    statusLabel.frame = CGRectMake(instance.center.x - (statusLabel.frame.width / 2), successImageView.frame.origin.y + successImageView.frame.height + 30, statusLabel.frame.width, statusLabel.frame.height)
                    
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
                
                NSTimer.scheduledTimerWithTimeInterval(tvProgress.displayDurationForString(status), target: self, selector: #selector(dismiss), userInfo: nil, repeats: false)
//                strongSelf.fadeOutTimer = [NSTimer timerWithTimeInterval:duration target:strongSelf selector:@selector(dismiss) userInfo:nil repeats:NO];
//                [[NSRunLoop mainRunLoop] addTimer:strongSelf.fadeOutTimer forMode:NSRunLoopCommonModes];
            }
        }
    }
}