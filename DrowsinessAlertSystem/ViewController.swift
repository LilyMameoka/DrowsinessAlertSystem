//
//  ViewController.swift
//  DrowsinessAlertSystem
//
//  Created by Lily Mameoka on 2020/08/01.
//  Copyright © 2020 Lily Mameoka. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController, SFSafariViewControllerDelegate {
    
    var startButton: UIButton!
    var usageButton: UIButton!
    var privacyPolicyButton: UIButton!
    var titleImageView: UIImageView!
    var dasImage: UIImage!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.black
        super.viewDidLoad()
        createIcon()
        createButtons()
    }
    
    func createIcon() {
        dasImage = UIImage(named: "DAS003")!
        titleImageView = UIImageView(image: dasImage)
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        titleImageView.contentMode = .scaleAspectFit
        view.addSubview(titleImageView)
        titleImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 320).isActive = true
        titleImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        titleImageView.widthAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
    }
    
    func createButtons() {
        startButton = UIButton()
        startButton.frame = view.frame
        startButton.backgroundColor = UIColor.black
        startButton.tintColor = UIColor.white
        startButton.setTitle("Start", for: .normal)
        startButton.addTarget(self, action: #selector(startButton_TouchUpInside(_:)), for: UIControl.Event.touchUpInside)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startButton)
        startButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50).isActive = true
        startButton.layer.borderColor = UIColor.white.cgColor
        startButton.layer.borderWidth = 1
        startButton.layer.cornerRadius = 10
        
        usageButton = UIButton()
        usageButton.frame = view.frame
        usageButton.backgroundColor = UIColor.black
        usageButton.tintColor = UIColor.white
        usageButton.setTitle("Usage", for: .normal)
        usageButton.addTarget(self, action: #selector(usageButton_TouchUpInside(_:)), for: UIControl.Event.touchUpInside)
        usageButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usageButton)
        usageButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        usageButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        usageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        usageButton.centerYAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 75).isActive = true
        usageButton.layer.borderColor = UIColor.white.cgColor
        usageButton.layer.borderWidth = 1
        usageButton.layer.cornerRadius = 10
        
        privacyPolicyButton = UIButton()
        privacyPolicyButton.frame = view.frame
        privacyPolicyButton.backgroundColor = UIColor.black
        privacyPolicyButton.tintColor = UIColor.white
        privacyPolicyButton.setTitle("PrivacyPolicy", for: .normal)
        privacyPolicyButton.addTarget(self, action: #selector(privacyPolicyButton_TouchUpInside(_:)), for: UIControl.Event.touchUpInside)
        privacyPolicyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(privacyPolicyButton)
        privacyPolicyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        privacyPolicyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        privacyPolicyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
    }
    
    @objc func startButton_TouchUpInside(_ sender: Any) {
        self.performSegue(withIdentifier: "showDASSegue", sender: nil)
    }

    @objc func usageButton_TouchUpInside(_ sender: Any) {
        let privacyPolicyURL: URL = URL(string: "http://lilymameoka.html.xdomain.jp/HybridMapPrivacyPolicy.html")!
        let safariViewController = SFSafariViewController(url: privacyPolicyURL)
        safariViewController.delegate = self
        present(safariViewController, animated: true, completion: nil)
    }
    
    @objc func privacyPolicyButton_TouchUpInside(_ sender: Any) {
        let privacyPolicyURL: URL = URL(string: "http://lilymameoka.html.xdomain.jp/HybridMapPrivacyPolicy.html")!
        let safariViewController = SFSafariViewController(url: privacyPolicyURL)
        safariViewController.delegate = self
        present(safariViewController, animated: true, completion: nil)
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true, completion: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showDASSegue" {
//            let nextVC = segue.destination as! DASViewController
//            nextVC.prop = val
//        }
//    }

}

