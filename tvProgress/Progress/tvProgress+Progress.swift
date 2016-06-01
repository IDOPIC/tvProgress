//
//  tvProgress+Progress.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation

extension tvProgress {
    //MARK: - Properties
    internal var progressType: tvProgressType? {
        get {
            return self.progressType ?? .FlatCircle()
        }
        set(newProgress) {
            self.progressType = newProgress ?? .FlatCircle()
        }
    }
    
    //MARK: - Methods
    internal func showProgress(progress: Double) -> Void {
        //TODO: - Implementation
    }
}