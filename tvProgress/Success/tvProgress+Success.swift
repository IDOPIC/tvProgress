//
//  tvProgress+Success.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation

extension tvProgress {
    //MARK: - Methods
    /**
     If your loading success, you can display a message that gives information about what happened to the user
     
     - Parameters:
        - status: specify a text to display
        - successImage: specify an image to be displayed instead of the default image
        - style: specify a style using tvProgressStyle enum
        - action: it's a tuple that contains a label and a closure. If you specify this parameter, the label will be use to generate a button while the closure will be executed when the user presses the button
        - menuButtonDidPress: specify a closure to be executed when the user press the Menu button while tvProgress is displayed
        - playButtonDidPress: specify a closure to be executed when the user press the Play/Pause button while tvProgress is displayed
     */
    public static func showSuccessWithStatus(status: String? = .None, andSuccessImage successImage: UIImage? = .None, andStyle style: tvProgressStyle? = .None, andAction action: (label: String, closure: (Void -> Void))? = .None, menuButtonDidPress: (() -> Void)? = .None, playButtonDidPress: (() -> Void)? = .None, completion: (() -> Void)? = .None) -> Void {
        let instance: tvProgress = tvProgress.sharedInstance
        NSOperationQueue.mainQueue().addOperationWithBlock() { () -> Void in
            if !instance.isVisible {
                var views: [UIView] = []
                let si: UIImage = successImage ?? instance.successImage
                let successImageView: UIImageView = UIImageView(frame: CGRectMake(instance.center.x - si.size.width / 2, instance.center.y - si.size.height / 2, si.size.width, si.size.height))
                successImageView.image = si
                successImageView.tintColor = (style ?? instance.style).mainColor
                views.insert(successImageView, atIndex: 0)
                
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
                
                tvProgress.showWithInstance(instance, andVisibleType: visibleType.Success(), andViews: views, andStyle: style, menuButtonDidPress: menuButtonDidPress, playButtonDidPress: playButtonDidPress, completion: completion)
                
                if let s = status where action == nil {
                    NSTimer.scheduledTimerWithTimeInterval(tvProgress.displayDurationForString(s), target: self, selector: #selector(dismiss), userInfo: nil, repeats: false)
                }
            }
        }
    }
}