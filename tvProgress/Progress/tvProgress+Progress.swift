//
//  tvProgress+Progress.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation

extension tvProgress {
    //MARK: - Properties
    public var progressType: tvProgressType! {
        get {
            return self._progressType ?? .FlatCircle()
        }
        set(newProgress) {
            self._progressType = newProgress ?? .FlatCircle()
        }
    }
    
    //MARK: - Methods
    /**
     Method to display or to update a progress animation
     
     - Parameters:
        - progress: value of progress (must be between 0 and 1)
        - status: specify a text to display
        - contentView: for displaying the progress view on a specific UIView
        - progressType: specify a type using tvProgressType enum
        - style: specify a style using tvProgressStyle enum
        - addBlurView: enable/disable the background blur view
        - menuButtonDidPress: specify a closure to be executed when the user press the Menu button while tvProgress is displayed
        - playButtonDidPress: specify a closure to be executed when the user press the Play/Pause button while tvProgress is displayed
     */
    static public func showProgress(progress: Double = 0, status: String? = .None, contentView: UIView? = .None, progressType pt: tvProgressType? = .None, style: tvProgressStyle? = .None, withBlurView addBlurView: Bool = true, menuButtonDidPress: (() -> Void)? = .None, playButtonDidPress: (() -> Void)? = .None, completion: (() -> Void)? = .None) -> Void {
        let instance: tvProgress = tvProgress.sharedInstance
        NSOperationQueue.mainQueue().addOperationWithBlock() { () -> Void in
            if !instance.isVisible {
                instance.frame = contentView?.bounds ?? UIScreen.mainScreen().bounds
                var views: [UIView] = []
                let progress: tvProgressAnimatable = (pt ?? instance.progressType).getInstance
                let cnfg: (view: UIView, completion: () -> Void) = progress.configureWithStyle(style ?? instance.style)
                let loaderView: UIView = cnfg.0
                loaderView.frame = CGRectMake(instance.center.x - (loaderView.frame.width / 2), instance.center.y - (loaderView.frame.height / 2), loaderView.frame.width, loaderView.frame.height)
                instance._finishLoaderCompletion = cnfg.completion
                views.insert(loaderView, atIndex: 0)
                
                let sLabel: UILabel?
                if let s = status {
                    sLabel = tvProgress.generateStatusLabelWithInstance(instance, andStatus: s, andStyle: style ?? instance.style)
                    let v: UIView = views[views.count - 1]
                    sLabel!.frame = CGRectMake(instance.center.x - (sLabel!.frame.width / 2), v.frame.origin.y + v.frame.height + 30, sLabel!.frame.width, sLabel!.frame.height)
                    views.insert(sLabel!, atIndex: views.count)
                } else {
                    sLabel = .None
                }
                
                tvProgress.showWithInstance(instance, andVisibleType: visibleType.Progress(view: progress, statusLabel: sLabel), andContent: contentView, andViews: views, andStyle: style, withBlurView: addBlurView, menuButtonDidPress: menuButtonDidPress, playButtonDidPress: playButtonDidPress, completion: completion)
            } else if let v: visibleType = instance._isVisible {
                switch v {
                case .Progress(let p, let sLabel):
                    p.updateProgress(progress)
                    if let s: String = status {
                        let tmpFrame: CGRect = tvProgress.generateStatusLabelWithInstance(instance, andStatus: s, andStyle: style ?? instance.style).frame
                        sLabel?.frame = CGRectMake(instance.center.x - (tmpFrame.width / 2), sLabel?.frame.origin.y ?? 0, tmpFrame.width, tmpFrame.height)
                    }
                    sLabel?.text = status
                    break
                default:
                    break
                }
            }
        }
    }
}