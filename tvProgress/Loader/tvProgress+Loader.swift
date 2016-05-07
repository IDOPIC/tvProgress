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
    public static func show(status: String? = .None, loaderType lt: tvLoaderType? = .None, style: tvProgressStyle? = .None) -> Void {
        let instance: tvProgress = tvProgress.sharedInstance
        if !instance._isVisible {
            let loader: (view: UIView, completion: () -> Void) = (lt ?? instance.loaderType).getInstance(style ?? instance.style)
            let loaderView: UIView = loader.0
            loaderView.frame = CGRectMake(instance.center.x - (loaderView.frame.width / 2), instance.center.y - (loaderView.frame.height / 2), loaderView.frame.width, loaderView.frame.height)
            instance.finishLoaderCompletion = loader.completion
            
            tvProgress.showWithStatus(status, view: loaderView, style: style)
        }
    }
}