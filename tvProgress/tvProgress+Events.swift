//
//  tvProgress+Events.swift
//  tvProgress
//
//  Created by Antoine Cormery on 09/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation

extension tvProgress {
    public var menuButtonDidPress: (() -> Void)? {
        get {
            return self._menuButtonPressClosure
        } set {
            self._menuButtonPressClosure = newValue
        }
    }
    
    public var playPauseButtonDidPress: (() -> Void)? {
        get {
            return self._playPauseButtonPressClosure
        } set {
            self._playPauseButtonPressClosure = newValue
        }
    }
    
    internal func menuButtonDidPress(_: AnyObject) -> Void {
        self._menuButtonPressClosure?()
    }
    
    internal func playPauseButtonDidPress(_: AnyObject) -> Void {
        self._playPauseButtonPressClosure?()
    }
    
    private func getEventCatch(events: [AnyObject]? = .None, getter: ((events: [AnyObject]) -> Void)? = .None) -> Void {
        struct __ {
            static var events: [AnyObject] = []
        }
        if getter != nil {
            getter?(events: __.events)
        }
        if events != nil {
            __.events = events!
        }
    }
    
    internal func setEventCatch() -> Void {
        let tapMenuGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tvProgress.menuButtonDidPress(_:)))
        tapMenuGesture.allowedPressTypes = [NSNumber(integer: (UIPressType.Menu.rawValue))]
        self.addGestureRecognizer(tapMenuGesture)
        
        let tapPlayPauseGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tvProgress.playPauseButtonDidPress(_:)))
        tapPlayPauseGesture.allowedPressTypes = [NSNumber(integer: (UIPressType.PlayPause.rawValue))]
        self.addGestureRecognizer(tapPlayPauseGesture)
        
        self.getEventCatch([tapMenuGesture, tapPlayPauseGesture])
    }
    
    internal func removeEventCatch() -> Void {
        self.getEventCatch([]) { (events: [AnyObject]) -> Void in
            for event in events where event is UITapGestureRecognizer {
                self.removeGestureRecognizer(event as! UITapGestureRecognizer)
            }
        }
    }
}