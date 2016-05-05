//
//  tvProgress.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import UIKit

class tvProgress: UIView {
    var isVisible: Bool = false
    var style: tvProgressStyle = .Light
    var loaderType: tvLoaderType = .Default()
    var progressType: tvProgressType = .Default()
    var font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    var successImage: UIImage = UIImage(named: "ic_success")!.imageWithRenderingMode(.AlwaysTemplate)
    var errorImage: UIImage = UIImage(named: "ic_error")!.imageWithRenderingMode(.AlwaysTemplate)
    var minimumDismissDuration: Double = 5
    var fadeInAnimationDuration: Double = 0.15
    var fadeOutAnimationDuration: Double = 0.15
    
    static let sharedInstance: tvProgress = {
        let instance = tvProgress()
        
        instance.frame = UIScreen.mainScreen().bounds
        instance.alpha = 0
        instance.userInteractionEnabled = false
        
        return instance
    }()
    
    func dismiss() -> Void {
        //TODO: - Implementation
    }
    
    func dismissWithDelay(delay: Double) -> Void {
        //TODO: - Implementation
    }
}
