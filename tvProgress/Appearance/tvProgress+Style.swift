//
//  tvProgress+Appearance.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation

public extension tvProgress {
    //MARK: - Properties
    public var style: tvProgressStyle! {
        get {
            return self._style ?? .light
        }
        set(newStyle) {
            self._style = newStyle ?? .light
        }
    }
    
    public var font: UIFont! {
        get {
            return self._font ?? UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        }
        set(newFont) {
            self._font = newFont ?? UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        }
    }
    
    public var successImage: UIImage! {
        get {
            return self._successImage ?? UIImage(named: "ic_success", in: Bundle(for: tvProgress.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        }
        set(newImage) {
            self._successImage = newImage ?? UIImage(named: "ic_success", in: Bundle(for: tvProgress.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    public var errorImage: UIImage! {
        get {
            return self._errorImage ?? UIImage(named: "ic_error", in: Bundle(for: tvProgress.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)

        }
        set(newImage) {
            self._errorImage = newImage ?? UIImage(named: "ic_error", in: Bundle(for: tvProgress.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)

        }
    }
    
    public var minimumDismissDuration: Double! {
        get {
            return self._minimumDismissDuration ?? 5
        }
        set(newMin) {
            self._minimumDismissDuration = newMin ?? 5
        }
    }
    
    public var fadeInAnimationDuration: Double! {
        get {
            return self._fadeInAnimationDuration ?? 0.15
        }
        set(newMin) {
            self._fadeInAnimationDuration = newMin ?? 0.15
        }
    }
    
    public var fadeOutAnimationDuration: Double! {
        get {
            return self._fadeOutAnimationDuration ?? 0.15
        }
        set(newMin) {
            self._fadeOutAnimationDuration = newMin ?? 0.15
        }
    }
}
