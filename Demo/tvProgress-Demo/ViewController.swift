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
    @IBAction func showAction(_ sender: AnyObject) {
        tvProgress.show()
        
        Timer.scheduledTimer(timeInterval: TimeInterval(5), target: self, selector: #selector(dismissAction), userInfo: nil, repeats: false)
    }
    
    @IBAction func showWithStatusAction(_ sender: AnyObject) {
        tvProgress.show("Loading ...")
        
        Timer.scheduledTimer(timeInterval: TimeInterval(5), target: self, selector: #selector(dismissAction), userInfo: nil, repeats: false)
    }
    
    @IBAction func showWithStyleAction(_ sender: AnyObject) {
        tvProgress.show(style: tvProgressStyle.dark)
        
        Timer.scheduledTimer(timeInterval: TimeInterval(5), target: self, selector: #selector(dismissAction), userInfo: nil, repeats: false)
    }
    
    @IBAction func showWithStatusAndStyleAction(_ sender: AnyObject) {
        tvProgress.show("Loading ...", style: tvProgressStyle.dark)
        
        Timer.scheduledTimer(timeInterval: TimeInterval(5), target: self, selector: #selector(dismissAction), userInfo: nil, repeats: false)
    }
    
    @IBAction func showAndroidStyleAction(_ sender: AnyObject) {
        tvProgress.show(loaderType: tvLoaderType.androidStyle(), style: tvProgressStyle.dark)
        
        Timer.scheduledTimer(timeInterval: TimeInterval(5), target: self, selector: #selector(dismissAction), userInfo: nil, repeats: false)
    }
    
    @IBAction func customLoaderButtonAction(_ sender: AnyObject) {
        tvProgress.show(loaderType: tvLoaderType.custom(cl: SweebiLoader.self), style: tvProgressStyle.dark)
        
        Timer.scheduledTimer(timeInterval: TimeInterval(5), target: self, selector: #selector(dismissAction), userInfo: nil, repeats: false)
    }
    
    @IBAction func showSuccessMessageAction(_ sender: AnyObject) {
        tvProgress.showSuccessWithStatus("This is a success")
    }
    
    @IBAction func showErrorMessageAction(_ sender: AnyObject) {
        tvProgress.showErrorWithStatus("This is an error", menuButtonDidPress: { () -> Void in
            debugPrint("Menu button did press closure")
        }) { () -> Void in
            debugPrint("Play/Pause button did press closure")
        }
    }
    
    @IBAction func showSuccessWithActionAction(_ sender: AnyObject) {
        tvProgress.showSuccessWithStatus("This is a success with Action !", andAction: ("Execute action", { () in
            debugPrint("Yeah!")
            tvProgress.dismiss()
        }))
    }
    
    var progress: Int = -1
    
    @IBAction func showOnContentViewAction(_ sender: AnyObject) {
        tvProgress.show(.none, contentView: self.contentViewOutlet, loaderType: tvLoaderType.default(), style: tvProgressStyle.light, withBlurView: false)
        
        Timer.scheduledTimer(timeInterval: TimeInterval(5), target: self, selector: #selector(dismissAction), userInfo: nil, repeats: false)
    }
    
    @IBAction func showProgressAction(_ sender: AnyObject) {
        if self.progress < 0 {
            self.progress = 0
            tvProgress.showProgress(0, style: .dark)
            Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(self.progressFu), userInfo: nil, repeats: false)
        }
    }
    
    @IBAction func showCustomProgressAction(_ sender: AnyObject) {
        if self.progress < 0 {
            self.progress = 0
            tvProgress.showProgress(status: "0%", progressType: tvProgressType.custom(cp: SweebiProgress.self), style: .dark)
            Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(self.progressFu), userInfo: nil, repeats: false)
        }
    }
    
    func progressFu() -> Void {
        self.progress += 10
        if self.progress <= 100 {
            tvProgress.showProgress(Double(self.progress) / 100, status: "\(self.progress)%")
        }
        
        if self.progress <= 100 {
            Timer.scheduledTimer(timeInterval: TimeInterval((self.progress <= 80) ? 0.5 : 0.25), target: self, selector: #selector(self.progressFu), userInfo: nil, repeats: false)
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

