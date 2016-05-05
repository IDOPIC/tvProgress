//
//  ViewController.swift
//  tvProgressDemo
//
//  Created by Antoine Cormery on 04/05/2016.
//  Copyright © 2016 Antoine Cormery. All rights reserved.
//

import UIKit
import tvProgress

class ViewController: UIViewController {

    @IBAction func showButtonAction(sender: AnyObject) {
        tvProgressView.sharedView().show()
    }
    
}

