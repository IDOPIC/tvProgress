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
    
    var progress: Double = 0
    
    @IBAction func showOnContentViewAction(sender: AnyObject) {
        /*tvProgress.show(.None, contentView: self.contentViewOutlet, loaderType: tvLoaderType.Default(), style: tvProgressStyle.Light, withBlurView: false)
        
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(5), target: self, selector: #selector(dismissAction), userInfo: nil, repeats: false)*/
        tvProgress.showProgress(0)
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1), target: self, selector: #selector(self.progressFu), userInfo: nil, repeats: false)
    }
    
    func progressFu() -> Void {
        self.progress += 0.1
        print(self.progress)
        if self.progress <= 1 {
            print("#1")
            tvProgress.showProgress(self.progress)
            NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1), target: self, selector: #selector(self.progressFu), userInfo: nil, repeats: false)
        } else {
            print("#2")
            tvProgress.dismiss()
            self.progress = 0
        }
    }
    
    func dismissAction() {
        debugPrint("dismiss")
        tvProgress.dismiss()
    }
}

