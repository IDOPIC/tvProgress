//
//  tvProgress.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import UIKit

public class tvProgress: UIView {
    //MARK: - Properties
    private var _isVisible: Bool = false
    public var isVisible: Bool {
        get {
            return _isVisible
        }
    }
    
    //MARK: - Singleton
    static let sharedInstance: tvProgress = {
        let instance = tvProgress()

        instance.frame = UIScreen.mainScreen().bounds
        instance.alpha = 0
        instance.userInteractionEnabled = false
        
        return instance
    }()
    
    //MARK: - Methods
    func dismiss() -> Void {
        //TODO: - Implementation
    }
    
    func dismissWithDelay(delay: Double) -> Void {
        //TODO: - Implementation
    }
}
