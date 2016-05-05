//
//  tvProgress+Appearance.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation

extension tvProgress {
    //MARK: - Properties
    public var style: tvProgressStyle! {
        get {
            return self.style ?? .Light
        }
        set(newStyle) {
            self.style = newStyle ?? .Light
        }
    }
    
    public var font: UIFont! {
        get {
            return self.font ?? UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        }
        set(newFont) {
            self.font = newFont ?? UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        }
    }
    
    public var successImage: UIImage! {
        get {
            return self.successImage ?? UIImage(named: "ic_success")!.imageWithRenderingMode(.AlwaysTemplate)
        }
        set(newImage) {
            self.successImage = newImage ?? UIImage(named: "ic_success")!.imageWithRenderingMode(.AlwaysTemplate)
        }
    }
    
    public var errorImage: UIImage! {
        get {
            return self.errorImage ?? UIImage(named: "ic_error")!.imageWithRenderingMode(.AlwaysTemplate)
        }
        set(newImage) {
            self.errorImage = newImage ?? UIImage(named: "ic_error")!.imageWithRenderingMode(.AlwaysTemplate)
        }
    }
    
    public var minimumDismissDuration: Double! {
        get {
            return self.minimumDismissDuration ?? 5
        }
        set(newMin) {
            self.minimumDismissDuration = newMin ?? 5
        }
    }
    
    public var fadeInAnimationDuration: Double! {
        get {
            return self.fadeInAnimationDuration ?? 5
        }
        set(newMin) {
            self.fadeInAnimationDuration = newMin ?? 5
        }
    }
    
    public var fadeOutAnimationDuration: Double! {
        get {
            return self.fadeOutAnimationDuration ?? 5
        }
        set(newMin) {
            self.fadeOutAnimationDuration = newMin ?? 5
        }
    }
}