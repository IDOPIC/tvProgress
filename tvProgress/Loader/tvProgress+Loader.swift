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
            return self._loaderType ?? .default()
        }
        set(newLoader) {
            self._loaderType = newLoader ?? .default()
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
        - marge: marging size for status label (right and left)
     */
    public static func show(_ status: String? = .none, contentView: UIView? = .none, loaderType lt: tvLoaderType? = .none, style: tvProgressStyle? = .none, withBlurView addBlurView: Bool = true, menuButtonDidPress: (() -> Void)? = .none, playButtonDidPress: (() -> Void)? = .none, andWithMarginTextSize marge: CGFloat = 400, completion: (() -> Void)? = .none) -> Void {
        let instance: tvProgress = tvProgress.sharedInstance
        OperationQueue.main.addOperation() { () -> Void in
            if !instance.isVisible {
                instance.frame = contentView?.bounds ?? UIScreen.main.bounds
                var views: [UIView] = []
                let loader: (view: UIView, completion: () -> Void) = (lt ?? instance.loaderType).getInstance(style ?? instance.style)
                let loaderView: UIView = loader.0
                loaderView.frame = CGRect(x: instance.center.x - (loaderView.frame.width / 2), y: instance.center.y - (loaderView.frame.height / 2), width: loaderView.frame.width, height: loaderView.frame.height)
                instance._finishLoaderCompletion = loader.completion
                views.insert(loaderView, at: 0)
                
                if let s = status {
                    let sLabel: UILabel = tvProgress.generateStatusLabelWithInstance(instance, andStatus: s, andStyle: style ?? instance.style, andWithMaxWidth: UIScreen.main.bounds.width - marge)
                    let v: UIView = views[views.count - 1]
                    sLabel.frame = CGRect(x: instance.center.x - (sLabel.frame.width / 2), y: v.frame.origin.y + v.frame.height + 30, width: sLabel.frame.width, height: sLabel.frame.height)
                    views.insert(sLabel, at: views.count)
                }
                
                tvProgress.showWithInstance(instance, andVisibleType: visibleType.loader(), andContent: contentView, andViews: views, andStyle: style, withBlurView: addBlurView, menuButtonDidPress: menuButtonDidPress, playButtonDidPress: playButtonDidPress, completion: completion)
            }
        }
    }
}
