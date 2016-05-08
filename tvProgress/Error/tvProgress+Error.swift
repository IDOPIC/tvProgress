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
    public static func showErrorWithStatus(status: String, errorImage ei: UIImage? = .None, style: tvProgressStyle? = .None) -> Void {
        let instance: tvProgress = tvProgress.sharedInstance
        NSOperationQueue.mainQueue().addOperationWithBlock() { () -> Void in
            if !instance._isVisible {
                let errorIm: UIImage = ei ?? instance.errorImage
                let errorImageView: UIImageView = UIImageView(frame: CGRectMake(instance.center.x - errorIm.size.width / 2, instance.center.y - errorIm.size.height / 2, errorIm.size.width, errorIm.size.height))
                errorImageView.image = errorIm
                errorImageView.tintColor = (style ?? tvProgressStyle.Light).mainColor
                
                tvProgress.showWithStatus(status, instance: instance, view: errorImageView, style: style)
                
                NSTimer.scheduledTimerWithTimeInterval(tvProgress.displayDurationForString(status), target: self, selector: #selector(dismiss), userInfo: nil, repeats: false)
            }
        }
    }
}