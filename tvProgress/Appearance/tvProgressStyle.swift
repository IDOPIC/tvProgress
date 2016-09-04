//
//  tvProgressStyle.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation

/**
 Style for displaying loader
 
 - Dark: style where the main color is white, the secondary color is black and the blur effect style is .Dark
 - Light: style where the main color is black, the secondary color is white and the blur effect style is .Light
 - Custom: you can create your own style, by specifying a main color, a secondary color and a blur effect style
 */
public enum tvProgressStyle {
    case dark
    case light
    case custom(mainColor: UIColor, secondaryColor: UIColor, blurStyle: UIBlurEffectStyle)
    
    public var mainColor: UIColor {
        switch self {
        case .dark:
            return UIColor.white
        case .light:
            return UIColor.black
        case .custom(let mainColor, _, _):
            return mainColor
        }
    }
    
    public var secondaryColor: UIColor {
        switch self {
        case .dark:
            return UIColor.black
        case .light:
            return UIColor.white
        case .custom(_, let secondaryColor, _):
            return secondaryColor
        }
    }
    
    public var blurStyle: UIBlurEffectStyle {
        switch self {
        case .dark:
            return .dark
        case .light:
            return .light
        case .custom(_, _, let customBlurStyle):
            return customBlurStyle
        }
    }
}
