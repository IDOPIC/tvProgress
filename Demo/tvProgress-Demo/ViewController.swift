//
//  ViewController.swift
//  tvProgress-Demo
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 tvProgress. All rights reserved.
//

import UIKit
import tvProgress

class ViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var contentViewOutlet: UIView!
    
    //MARK: - IBActions
    @IBAction func showAction(sender: AnyObject) {
        tvProgress.show()
        
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(5), target: self, selector: #selector(dismissAction), userInfo: nil, repeats: false)
    }
    
    @IBAction func showWithStatusAction(sender: AnyObject) {
        tvProgress.show("Loading ...")
        
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(5), target: self, selector: #selector(dismissAction), userInfo: nil, repeats: false)
    }
    
    @IBAction func showWithStyleAction(sender: AnyObject) {
        tvProgress.show(style: tvProgressStyle.Dark)
        
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(5), target: self, selector: #selector(dismissAction), userInfo: nil, repeats: false)
    }
    
    @IBAction func showWithStatusAndStyleAction(sender: AnyObject) {
        tvProgress.show("Loading ...", style: tvProgressStyle.Dark)
        
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(5), target: self, selector: #selector(dismissAction), userInfo: nil, repeats: false)
    }
    
    @IBAction func showAndroidStyleAction(sender: AnyObject) {
        tvProgress.show(loaderType: tvLoaderType.AndroidStyle(), style: tvProgressStyle.Dark)
        
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(5), target: self, selector: #selector(dismissAction), userInfo: nil, repeats: false)
    }
    
    @IBAction func customLoaderButtonAction(sender: AnyObject) {
        tvProgress.show(loaderType: tvLoaderType.Custom(cl: SweebiLoader.self), style: tvProgressStyle.Dark)
        
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(5), target: self, selector: #selector(dismissAction), userInfo: nil, repeats: false)
    }
    
    @IBAction func showSuccessMessageAction(sender: AnyObject) {
        tvProgress.showSuccessWithStatus("This is a success")
    }
    
    @IBAction func showErrorMessageAction(sender: AnyObject) {
        tvProgress.showErrorWithStatus("This is an error", menuButtonDidPress: { () -> Void in
            debugPrint("Menu button did press closure")
        }) { () -> Void in
            debugPrint("Play/Pause button did press closure")
        }
    }
    
    @IBAction func showSuccessWithActionAction(sender: AnyObject) {
        tvProgress.showSuccessWithStatus("This is a success with Action !", andAction: ("Execute action", { () in
            debugPrint("Yeah!")
            tvProgress.dismiss()
        }))
    }
    
    var progress: Int = -1
    
    @IBAction func showOnContentViewAction(sender: AnyObject) {
        tvProgress.show(.None, contentView: self.contentViewOutlet, loaderType: tvLoaderType.Default(), style: tvProgressStyle.Light, withBlurView: false)
        
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(5), target: self, selector: #selector(dismissAction), userInfo: nil, repeats: false)
    }
    
    @IBAction func showProgressAction(sender: AnyObject) {
        if self.progress < 0 {
            self.progress = 0
            tvProgress.showProgress(0, style: .Dark)
            NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1), target: self, selector: #selector(self.progressFu), userInfo: nil, repeats: false)
        }
    }
    
    @IBAction func showCustomProgressAction(sender: AnyObject) {
        if self.progress < 0 {
            self.progress = 0
            tvProgress.showProgress(status: "0%", style: .Dark, progressType: tvProgressType.Custom(cp: SweebiProgress.self))
            NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1), target: self, selector: #selector(self.progressFu), userInfo: nil, repeats: false)
        }
    }
    
    func progressFu() -> Void {
        self.progress += 10
        if self.progress <= 100 {
            tvProgress.showProgress(Double(self.progress) / 100, status: "\(self.progress)%")
        }
        
        if self.progress <= 100 {
            NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval((self.progress <= 80) ? 0.5 : 0.25), target: self, selector: #selector(self.progressFu), userInfo: nil, repeats: false)
        } else {
            tvProgress.dismiss()
            self.progress = -1
        }
    }
    
    func dismissAction() {
        debugPrint("dismiss")
        tvProgress.dismiss()
    }
}

