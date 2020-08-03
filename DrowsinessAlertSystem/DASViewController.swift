//
//  DASViewController.swift
//  DrowsinessAlertSystem
//
//  Created by Lily Mameoka on 2020/08/02.
//  Copyright © 2020 Lily Mameoka. All rights reserved.
//

import UIKit
import ARKit
import AVFoundation

class DASViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    var mainImageView: UIImageView!
    var mainImage: UIImage!
    var backButton: UIButton!
    var blackView: UIView!
    var audioPlayer : AVAudioPlayer! = nil
    var leftEyeVal: Float = 0
    var rightEyeVal: Float = 0
    var closeTime: Float = 0
    var eyeJudgeVal: Float = 0.3
    var timeJudgeVal: Float = 15
    
    let defaultConfiguration: ARFaceTrackingConfiguration = {
        let configuration = ARFaceTrackingConfiguration()
        return configuration
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sceneView.session.run(defaultConfiguration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    override func viewDidLoad() {
        view.backgroundColor = UIColor.black
        super.viewDidLoad()
        guard ARFaceTrackingConfiguration.isSupported else {
            fatalError()
        }
        createUI()
        makeSound(name: "famima")
        sceneView.delegate = self
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        DispatchQueue.global().async {
            guard let faceAnchor = anchor as? ARFaceAnchor else {
                return
            }
            
            if let leftEyeBlink = faceAnchor.blendShapes[.eyeBlinkLeft] as? Float{
                self.leftEyeVal = leftEyeBlink
            }
            if let rightEyeBlink = faceAnchor.blendShapes[.eyeBlinkRight] as? Float{
                self.rightEyeVal = rightEyeBlink
            }
            
            if (self.leftEyeVal>self.eyeJudgeVal)&&(self.rightEyeVal>self.eyeJudgeVal){
                self.closeTime+=1
                if(self.closeTime>self.timeJudgeVal){
                    DispatchQueue.main.async{
                        self.audioPlayer.play()
                        self.performSegue(withIdentifier: "showRecorderSegue", sender: nil)
                    }
                }
            } else {
                self.closeTime = 0
            }
        }
        
    }
    
    func makeSound(name: String) {
        let soundFilePathClear : NSString = Bundle.main.path(forResource: name, ofType: "mp3")! as NSString
        let soundClear : NSURL = NSURL(fileURLWithPath: soundFilePathClear as String)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        } catch {
            print("Failed AVAudioPlayer Instance")
        }
        audioPlayer.prepareToPlay()
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
    
    func createIcon() {
        mainImage = UIImage(named: "DAS001")!
        mainImageView = UIImageView(image: mainImage)
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.contentMode = .scaleAspectFit
        view.addSubview(mainImageView)
        mainImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 520).isActive = true
        mainImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        mainImageView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
    }
    
    func createBlackView() {
        blackView = UIView()
        blackView.frame = view.frame
        blackView.backgroundColor = UIColor.black
        blackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blackView)
        blackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        blackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        blackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        blackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func createUI() {
        createBlackView()
        createButton()
        createIcon()
    }

}
