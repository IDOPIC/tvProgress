//
//  tvProgress+Error.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation

extension tvProgress {
    //MARK: - Methods
    public static func showErrorWithStatus(status: String? = .None, andErrorImage errorImage: UIImage? = .None, andStyle style: tvProgressStyle? = .None, andAction action: (label: String, closure: (Void -> Void))? = .None) -> Void {
        let instance: tvProgress = tvProgress.sharedInstance
        NSOperationQueue.mainQueue().addOperationWithBlock() { () -> Void in
            if !instance._isVisible {
                var views: [UIView] = []
                let ei: UIImage = errorImage ?? instance.errorImage
                let errorImageView: UIImageView = UIImageView(frame: CGRectMake(instance.center.x - ei.size.width / 2, instance.center.y - ei.size.height / 2, ei.size.width, ei.size.height))
                errorImageView.image = ei
                errorImageView.tintColor = (style ?? instance.style).mainColor
                views.insert(errorImageView, atIndex: 0)
                
                if let s = status {
                    let sLabel: UILabel = tvProgress.generateStatusLabelWithInstance(instance, andStatus: s, andStyle: style ?? instance.style)
                    let v: UIView = views[views.count - 1]
                    sLabel.frame = CGRectMake(instance.center.x - (sLabel.frame.width / 2), v.frame.origin.y + v.frame.height + 30, sLabel.frame.width, sLabel.frame.height)
                    views.insert(sLabel, atIndex: views.count)
                }
                
                if let act = action {
                    let button: UIButton = UIButton(type: .System)
                    button.setTitle(act.label, forState: .Normal)
                    //button.backgroundColor = (style ?? instance.style).mainColor
                    //button.setTitleColor((style ?? instance.style)?.secondaryColor, forState: .Normal)
                    button.sizeToFit()
                    button.actionHandleWithAction(act.closure)
                    let v: UIView = views[views.count - 1]
                    button.frame = CGRectMake(instance.center.x - (button.frame.width / 2), v.frame.origin.y + v.frame.height + 50, button.frame.width, button.frame.height)
                    
                    views.insert(button, atIndex: views.count)
                }
                
                tvProgress.showWithInstance(instance, andViews: views, andStyle: style)
                
                if let s = status where action == nil {
                    NSTimer.scheduledTimerWithTimeInterval(tvProgress.displayDurationForString(s), target: self, selector: #selector(dismiss), userInfo: nil, repeats: false)
                }
            }
        }
    }
}