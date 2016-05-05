//
//  tvProgress+Loader.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation

extension tvProgress {
    //MARK: - Properties
    public var loaderType: tvLoaderType? {
        get {
            return self.loaderType ?? .Default()
        }
        set(newLoader) {
            self.loaderType = newLoader ?? .Default()
        }
    }
    
    //MARK: - Methods
    func show() -> Void {
        //TODO: - Implementation
    }
    
    func showWithStatus(status: String) -> Void {
        //TODO: - Implementation
    }
}