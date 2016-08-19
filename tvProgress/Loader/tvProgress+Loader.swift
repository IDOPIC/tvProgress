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
    /**
     Method to display a simple animation
     
     - Parameters:
        - status: specify a text to display
        - contentView: for displaying the loader view on a specific UIView
        - loaderType: specify a type using tvLoaderType enum
        - style: specify a style using tvProgressStyle enum
        - addBlurView: enable/disable the background blur view
        - menuButtonDidPress: specify a closure to be executed when the user press the Menu button while tvProgress is displayed
        - playButtonDidPress: specify a closure to be executed when the user press the Play/Pause button while tvProgress is displayed
     */
    public static func show(status: String? = .None, contentView: UIView? = .None, loaderType lt: tvLoaderType? = .None, style: tvProgressStyle? = .None, withBlurView addBlurView: Bool = true, menuButtonDidPress: (() -> Void)? = .None, playButtonDidPress: (() -> Void)? = .None, completion: (() -> Void)? = .None) -> Void {
        let instance: tvProgress = tvProgress.sharedInstance
        NSOperationQueue.mainQueue().addOperationWithBlock() { () -> Void in
            if !instance.isVisible {
                instance.frame = contentView?.bounds ?? UIScreen.mainScreen().bounds
                var views: [UIView] = []
                let loader: (view: UIView, completion: () -> Void) = (lt ?? instance.loaderType).getInstance(style ?? instance.style)
                let loaderView: UIView = loader.0
                loaderView.frame = CGRectMake(instance.center.x - (loaderView.frame.width / 2), instance.center.y - (loaderView.frame.height / 2), loaderView.frame.width, loaderView.frame.height)
                instance._finishLoaderCompletion = loader.completion
                views.insert(loaderView, atIndex: 0)
                
                if let s = status {
                    let sLabel: UILabel = tvProgress.generateStatusLabelWithInstance(instance, andStatus: s, andStyle: style ?? instance.style)
                    let v: UIView = views[views.count - 1]
                    sLabel.frame = CGRectMake(instance.center.x - (sLabel.frame.width / 2), v.frame.origin.y + v.frame.height + 30, sLabel.frame.width, sLabel.frame.height)
                    views.insert(sLabel, atIndex: views.count)
                }
                
                tvProgress.showWithInstance(instance, andVisibleType: visibleType.Loader(), andContent: contentView, andViews: views, andStyle: style, withBlurView: addBlurView, menuButtonDidPress: menuButtonDidPress, playButtonDidPress: playButtonDidPress, completion: completion)
            }
        }
    }
}