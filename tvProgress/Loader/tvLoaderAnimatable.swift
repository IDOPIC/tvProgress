//
//  tvProgressAnimatableProtocol.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation

public protocol tvLoaderAnimatable: class {
    init()
    func configureWithStyle(style: tvProgressStyle) -> (view: UIView, completion: () -> Void)
}