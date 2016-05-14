//
//  tvProgressStyle.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation

public enum tvProgressStyle {
    case Dark
    case Light
    case Custom(mainColor: UIColor, secondaryColor: UIColor, blurStyle: UIBlurEffectStyle)
    
    public var mainColor: UIColor {
        switch self {
        case .Dark:
            return UIColor.whiteColor()
        case .Light:
            return UIColor.blackColor()
        case .Custom(let mainColor, _, _):
            return mainColor
        }
    }
    
    public var secondaryColor: UIColor {
        switch self {
        case .Dark:
            return UIColor.blackColor()
        case .Light:
            return UIColor.whiteColor()
        case .Custom(_, let secondaryColor, _):
            return secondaryColor
        }
    }
    
    public var blurStyle: UIBlurEffectStyle {
        switch self {
        case .Dark:
            return .Dark
        case .Light:
            return .Light
        case .Custom(_, _, let customBlurStyle):
            return customBlurStyle
        }
    }
}