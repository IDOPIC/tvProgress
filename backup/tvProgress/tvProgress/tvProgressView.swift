//
//  tvProgressView.swift
//  tvProgress
//
//  Created by Antoine Cormery on 04/05/2016.
//  Copyright © 2016 Antoine Cormery. All rights reserved.
//

import UIKit

public class tvProgressView: UIView {
    
    //MARK: - Static Properties
    
    private static var sharedInstance: tvProgressView!
    private static var instanceToken: dispatch_once_t = 0
    
    //MARK: - Static methods
    
    public static func sharedView() -> tvProgressView {
        dispatch_once(&instanceToken) {
            sharedInstance = tvProgressView()
        }
        return sharedInstance
    }

    //MARK: - Public Properties

    public var loaderInstance: tvProgressLoaderProtocol = tvProgressDefaultLoader()

    //MARK: - Private Properties
    
    private var mainView: UIView?
    private var blurView: UIVisualEffectView?
    
    //MARK: - Private methods
    
    private func initView() -> Void {
        self.frame = UIScreen.mainScreen().bounds
        
        self.mainView = UIView(frame: self.frame)
        
        let blurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        self.blurView = UIVisualEffectView(frame: self.mainView!.frame)
        self.blurView?.effect = blurEffect
        
        self.mainView?.addSubview(self.blurView!)
    }
    
    private func buildView() -> Void {
        self.buildLoader()
    }
    
    private func buildLoader() -> Void {
        let loader: UIView = self.loaderInstance.getLoader()
        loader.frame = CGRectMake((self.frame.width / 2) - (loader.frame.width / 2), (self.frame.height / 2) - (loader.frame.height / 2), loader.frame.width, loader.frame.height)
        self.mainView!.addSubview(loader)
    }
    
    //MARK: - Public methods
    
    public func show() -> Void {
        if self.mainView == nil {
            self.initView()
        }
        self.buildView()
        self.addSubview(self.mainView!)
        let tabWindow: [UIWindow] = UIApplication.sharedApplication().windows
        for w in tabWindow {
            if (w.screen == UIScreen.mainScreen() && !w.hidden && w.alpha > 0 && w.windowLevel == UIWindowLevelNormal) {
                self.alpha = 0
                w.addSubview(self)
                w.bringSubviewToFront(self)
                
                UIView.animateWithDuration(0.5) { () in
                    self.alpha = 1
                }
                break;
            }
        }
    }
    
    public func dismiss() -> Void {
        if self.mainView != nil {
            self.mainView?.willRemoveSubview(self.blurView!)
            self.willRemoveSubview(self.mainView!)
            self.mainView = nil
            
            self.removeFromSuperview()
        }
    }
}
