//
//  UIButton+closure.swift
//  tvProgress
//
//  Created by Cédric Eugeni on 09/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import Foundation

extension UIButton {
    private func actionHandleBlock(action:(() -> Void)? = nil) {
        struct __ {
            static var action: (() -> Void)?
        }
        if action != nil {
            __.action = action
        } else {
            __.action?()
        }
    }
    
    @objc private func triggerActionHandleBlock() -> Void {
        self.actionHandleBlock()
    }
    
    public func actionHandleWithAction(action: (() -> Void)) -> Void {
        self.actionHandleBlock(action)
        self.addTarget(self, action: #selector(triggerActionHandleBlock), forControlEvents: UIControlEvents.PrimaryActionTriggered)
    }
}