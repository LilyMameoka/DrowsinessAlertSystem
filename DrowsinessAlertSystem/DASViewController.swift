//
//  DASViewController.swift
//  DrowsinessAlertSystem
//
//  Created by Lily Mameoka on 2020/08/02.
//  Copyright © 2020 Lily Mameoka. All rights reserved.
//

import UIKit

class DASViewController: UIViewController {
    
    var backButton: UIButton!

    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        super.viewDidLoad()
        createButton()
    }
    
    func createButton() {
        backButton = UIButton()
        backButton.frame = view.frame
        backButton.backgroundColor = UIColor.black
        backButton.tintColor = UIColor.white
        backButton.setTitle("Back", for: .normal)
        backButton.addTarget(self, action: #selector(backButton_TouchUpInside(_:)), for: UIControl.Event.touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        backButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        backButton.layer.borderColor = UIColor.white.cgColor
        backButton.layer.borderWidth = 1
        backButton.layer.cornerRadius = 10
    }
    
    @objc func backButton_TouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
