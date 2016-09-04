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
 - Custom: your can create your own loader by using this enum, you must specify a tvLoaderAnimatable.Type
 */
public enum tvLoaderType {
    case `default`()
    case androidStyle()
    case custom(cl: tvLoaderAnimatable.Type)
    
    func getInstance(_ style: tvProgressStyle, frame: CGRect = CGRect.zero) -> (UIView, () -> Void) {
        switch self {
        case .default:
            let loader: FlatCircleLoader = FlatCircleLoader.init()
            return loader.configureWithStyle(style)
        case .androidStyle():
            let loader: AndroidStyleLoader = AndroidStyleLoader.init()
            return loader.configureWithStyle(style)
        case .custom(let cl):
            let loader: tvLoaderAnimatable = cl.init()
            return loader.configureWithStyle(style)
        }
    }
}
