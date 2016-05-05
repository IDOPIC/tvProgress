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
    public var progressType: tvProgressType? {
        get {
            return self.progressType ?? .Default()
        }
        set(newProgress) {
            self.progressType = newProgress ?? .Default()
        }
    }
    
    //MARK: - Methods
    func showProgress(progress: Double) -> Void {
        //TODO: - Implementation
    }
    
    func showProgress(progress: Double, withStatus status: String) -> Void {
        //TODO: - Implementation
    }
}