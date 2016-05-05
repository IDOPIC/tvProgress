//
//  tvProgress+Appearance.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation

extension tvProgress {
    func setDefaultStyle(style: tvProgressStyle) -> Void {
        self.style = style
    }
    
    func setDefaultLoaderAnimationType(type: tvLoaderType) -> Void {
        self.loaderType = type
    }
    
    func setDefaultProgressAnimationType(type: tvProgressType) -> Void {
        self.progressType = type
    }
    
    func setDefaultFont(font: UIFont?) -> Void {
        self.font = font ?? UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    }
    
    func setDefaultSuccessImage(image: UIImage?) -> Void {
        self.errorImage = image ?? UIImage(named: "ic_success")!.imageWithRenderingMode(.AlwaysTemplate)
    }
    
    func setDefaultErrorImage(image: UIImage?) -> Void {
        self.errorImage = image ?? UIImage(named: "ic_error")!.imageWithRenderingMode(.AlwaysTemplate)
    }
    
    func setMinimumDismissDuration(duration: Double?) -> Void {
        self.minimumDismissDuration = duration ?? 5
    }
    
    func setFadeInAnimationDuration(duration: Double?) -> Void {
        self.fadeInAnimationDuration = duration ?? 0.15
    }
    
    func setFadeOutAnimationDuration(duration: Double?) -> Void {
        self.fadeOutAnimationDuration = duration ?? 0.15
    }
}