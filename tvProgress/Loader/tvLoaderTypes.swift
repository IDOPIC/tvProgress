//
//  tvLoaderTypes.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation

enum tvLoaderTypes {
    case Default()
    case Custom(cl: tvLoaderAnimatable.Type)
}