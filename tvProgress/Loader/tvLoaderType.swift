//
//  tvLoaderTypes.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation

public enum tvLoaderType {
    case Default()
    case Custom(cl: tvLoaderAnimatable.Type)
    
    func getInstance(style: tvProgressStyle, frame: CGRect = CGRectZero) -> (UIView, () -> Void) {
        switch self {
        case .Default:
            let loader: FlatCircleLoader = FlatCircleLoader.init()
            return loader.configureWithStyle(style)
        case .Custom(let cl):
            let loader: tvLoaderAnimatable = cl.init()
            return loader.configureWithStyle(style)
        }
    }
}