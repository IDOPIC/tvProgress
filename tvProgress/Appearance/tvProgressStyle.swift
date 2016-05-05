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
    case Custom(mainColor: UIColor, secondaryColor: UIColor)
    
    var mainColor: UIColor {
        switch self {
        case .Dark:
            return UIColor.whiteColor()
        case .Light:
            return UIColor.blackColor()
        case .Custom(let mainColor, _):
            return mainColor
        }
    }
    
    var secondaryColor: UIColor {
        switch self {
        case .Light:
            return UIColor.blackColor()
        case .Dark:
            return UIColor.whiteColor()
        case .Custom(_, let secondaryColor):
            return secondaryColor
        }
    }
}