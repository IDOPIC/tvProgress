//
//  tvProgressTypes.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation

public enum tvProgressType {
    case FlatCircle()
    case Custom(cp: tvProgressAnimatable.Type)
    
    var getInstance: tvProgressAnimatable {
        switch self {
        case .FlatCircle:
            return FlatCircleProgress()
        case .Custom(let cp):
            return cp.init()
        }
    }
}