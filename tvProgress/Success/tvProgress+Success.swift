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
    public static func showSuccessWithStatus(status: String, successImage si: UIImage? = .None, style: tvProgressStyle? = .None) -> Void {
        let instance: tvProgress = tvProgress.sharedInstance
        NSOperationQueue.mainQueue().addOperationWithBlock() { () -> Void in
            if !instance._isVisible {
                let successIm: UIImage = si ?? instance.successImage
                let successImageView: UIImageView = UIImageView(frame: CGRectMake(instance.center.x - successIm.size.width / 2, instance.center.y - successIm.size.height / 2, successIm.size.width, successIm.size.height))
                successImageView.image = successIm
                successImageView.tintColor = (style ?? tvProgressStyle.Light).mainColor
                
                tvProgress.showWithStatus(status, instance: instance, view: successImageView, style: style)
                
                NSTimer.scheduledTimerWithTimeInterval(tvProgress.displayDurationForString(status), target: self, selector: #selector(dismiss), userInfo: nil, repeats: false)
            }
        }
    }
}