//
//  ViewController.swift
//  DrowsinessAlertSystem
//
//  Created by Lily Mameoka on 2020/08/01.
//  Copyright © 2020 Lily Mameoka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var startButton: UIButton!
    var usageButton: UIButton!
    var privacyPolicyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func createButtons() {
        startButton = UIButton()
        startButton.frame = view.frame
    }


}

