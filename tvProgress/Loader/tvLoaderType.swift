//
//  tvLoaderTypes.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation

/**
 Specify the loader rendering
 
 - Default: use the default loader
 - AndroidStyle: use an Android Style loader
 - Custom: your can create your own loader by using this enum, you must to specify a tvLoaderAnimatable.Type
 */
public enum tvLoaderType {
    case Default()
    case AndroidStyle()
    case Custom(cl: tvLoaderAnimatable.Type)
    
    func getInstance(style: tvProgressStyle, frame: CGRect = CGRectZero) -> (UIView, () -> Void) {
        switch self {
        case .Default:
            let loader: FlatCircleLoader = FlatCircleLoader.init()
            return loader.configureWithStyle(style)
        case .AndroidStyle():
            let loader: AndroidStyleLoader = AndroidStyleLoader.init()
            return loader.configureWithStyle(style)
        case .Custom(let cl):
            let loader: tvLoaderAnimatable = cl.init()
            return loader.configureWithStyle(style)
        }
    }
}