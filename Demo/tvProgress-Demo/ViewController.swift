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
    
    func dismissAction() {
        debugPrint("dismiss")
        tvProgress.dismiss()
    }
}

