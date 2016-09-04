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
            return self._progressType ?? .flatCircle()
        }
        set(newProgress) {
            self._progressType = newProgress ?? .flatCircle()
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
    static public func showProgress(_ progress: Double = 0, status: String? = .none, contentView: UIView? = .none, progressType pt: tvProgressType? = .none, style: tvProgressStyle? = .none, withBlurView addBlurView: Bool = true, menuButtonDidPress: (() -> Void)? = .none, playButtonDidPress: (() -> Void)? = .none, completion: (() -> Void)? = .none) -> Void {
        let instance: tvProgress = tvProgress.sharedInstance
        OperationQueue.main.addOperation() { () -> Void in
            if !instance.isVisible {
                instance.frame = contentView?.bounds ?? UIScreen.main.bounds
                var views: [UIView] = []
                let progress: tvProgressAnimatable = (pt ?? instance.progressType).getInstance
                let cnfg: (view: UIView, completion: () -> Void) = progress.configureWithStyle(style ?? instance.style)
                let loaderView: UIView = cnfg.0
                loaderView.frame = CGRect(x: instance.center.x - (loaderView.frame.width / 2), y: instance.center.y - (loaderView.frame.height / 2), width: loaderView.frame.width, height: loaderView.frame.height)
                instance._finishLoaderCompletion = cnfg.completion
                views.insert(loaderView, at: 0)
                
                let sLabel: UILabel?
                if let s = status {
                    sLabel = tvProgress.generateStatusLabelWithInstance(instance, andStatus: s, andStyle: style ?? instance.style)
                    let v: UIView = views[views.count - 1]
                    sLabel!.frame = CGRect(x: instance.center.x - (sLabel!.frame.width / 2), y: v.frame.origin.y + v.frame.height + 30, width: sLabel!.frame.width, height: sLabel!.frame.height)
                    views.insert(sLabel!, at: views.count)
                } else {
                    sLabel = .none
                }
                
                tvProgress.showWithInstance(instance, andVisibleType: visibleType.progress(view: progress, statusLabel: sLabel), andContent: contentView, andViews: views, andStyle: style, withBlurView: addBlurView, menuButtonDidPress: menuButtonDidPress, playButtonDidPress: playButtonDidPress, completion: completion)
            } else if let v: visibleType = instance._isVisible {
                switch v {
                case .progress(let p, let sLabel):
                    p.updateProgress(progress)
                    if let s: String = status {
                        let tmpFrame: CGRect = tvProgress.generateStatusLabelWithInstance(instance, andStatus: s, andStyle: style ?? instance.style).frame
                        sLabel?.frame = CGRect(x: instance.center.x - (tmpFrame.width / 2), y: sLabel?.frame.origin.y ?? 0, width: tmpFrame.width, height: tmpFrame.height)
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
