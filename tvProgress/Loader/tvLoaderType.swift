//
//  tvLoaderTypes.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation

enum tvLoaderType {
    case Default()
    case Custom(cl: tvLoaderAnimatable.Type, width: CGFloat, height: CGFloat)
    
    var getInstance: tvLoaderAnimatable? {
        switch self {
        case .Default:
            let view = FlatCircleLoader.init(frame: CGRectMake(0, 0, 100, 100))
            view.configure()
            
            return view
        case .Custom(let cl, let width, let height):
            let view = cl.init(frame: CGRectMake(0, 0, width, height))
            view.configure()
            
            return view
        }
    }
}