//
//  tvProgressTypes.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation

/**
 Specify the progress animation rendering

 - FlatCircle: use the default progress animation
 - Custom: you can create your own progress animation by using this enum, you must specify a tvProgressAnimatable.Type
 */
public enum tvProgressType {
    case flatCircle()
    case custom(cp: tvProgressAnimatable.Type)
    
    var getInstance: tvProgressAnimatable {
        switch self {
        case .flatCircle:
            return FlatCircleProgress()
        case .custom(let cp):
            return cp.init()
        }
    }
}
