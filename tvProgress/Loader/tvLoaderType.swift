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
    case Custom(cl: tvLoaderAnimatable.Type)
    
    var getInstance: tvLoaderAnimatable? {
        switch self {
        case .Default:
            return .None
        case .Custom(let cl):
            return cl.init(frame: CGRectMake(0, 0, 100, 100))
        }
    }
}