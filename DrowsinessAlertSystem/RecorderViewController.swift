//
//  RecorderViewController.swift
//  DrowsinessAlertSystem
//
//  Created by Lily Mameoka on 2020/08/03.
//  Copyright © 2020 Lily Mameoka. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class RecorderViewController: UIViewController, AVCaptureFileOutputRecordingDelegate {
    
    var warnImageView: UIImageView!
    var warnImage: UIImage!
    var session: AVCaptureSession!
    var videoDevice: AVCaptureDevice!
    var audioDevice: AVCaptureDevice!
    var fileOutput: AVCaptureMovieFileOutput!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createIcon()
        activateDriveRecorder()
    }
    
    func activateDriveRecorder() {
        session = AVCaptureSession()
        videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        let videoInput = try! AVCaptureDeviceInput.init(device: videoDevice)
        session.addInput(videoInput)
        switchFormat(desiredFps: 30.0)
        audioDevice = AVCaptureDevice.default(for: .audio)
        let audioInput = try! AVCaptureDeviceInput.init(device: audioDevice)
        session.addInput(audioInput)
        fileOutput = AVCaptureMovieFileOutput()
        session.addOutput(fileOutput)
        session.startRunning()
        startRecording()
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            self.fileOutput.stopRecording()
            self.outputVideos()
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func switchFormat(desiredFps: Double) {
        let isRunning = session.isRunning
        if isRunning { session.stopRunning() }
        var selectedFormat: AVCaptureDevice.Format! = nil
        var currentMaxWidth: Int32 = 0
        for format in videoDevice.formats {
            for range: AVFrameRateRange in format.videoSupportedFrameRateRanges {
                let description = format.formatDescription as CMFormatDescription
                let dimensions = CMVideoFormatDescriptionGetDimensions(description)
                let width = dimensions.width
                if desiredFps == range.maxFrameRate && currentMaxWidth <= width && width <= 1920 {
                    selectedFormat = format
                    currentMaxWidth = width
                }
            }
        }
        if selectedFormat != nil {
            do {
                try videoDevice.lockForConfiguration()
                videoDevice.activeFormat = selectedFormat
                videoDevice.activeVideoMinFrameDuration = CMTimeMake(value: 1, timescale: Int32(desiredFps))
                videoDevice.activeVideoMaxFrameDuration = CMTimeMake(value: 1, timescale: Int32(desiredFps))
                videoDevice.unlockForConfiguration()
                if isRunning { session.startRunning() }
            }
            catch {
                print("フォーマット・フレームレートが指定できなかった : \(desiredFps) fps")
            }
        }
        else {
            print("フォーマットが取得できなかった : \(desiredFps) fps")
        }
    }
    
    func startRecording() {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0] as String
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmssSSS"
        let filePath: String? = "\(documentsDirectory)/DrowsinessAlertSystem-\(formatter.string(from: Date())).mp4"
        let fileURL = NSURL(fileURLWithPath: filePath!)
        print("録画開始 : \(filePath!)")
        fileOutput?.startRecording(to: fileURL as URL, recordingDelegate: self)
    }
    
    func stopRecording() {
        print("録画停止")
        fileOutput?.stopRecording()
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        print("録画完了")
    }
    
    func outputVideos() {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let contentUrls = try FileManager.default.contentsOfDirectory(at: documentDirectoryURL, includingPropertiesForKeys: nil)
            for contentUrl in contentUrls {
                if contentUrl.pathExtension == "mp4" {
                    PHPhotoLibrary.shared().performChanges({
                        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: contentUrl)
                    }) { (isCompleted, error) in
                        if isCompleted {
                            do {
                                try FileManager.default.removeItem(atPath: contentUrl.path)
                                print("フォトライブラリ書き出し・ファイル削除成功 : \(contentUrl.lastPathComponent)")
                            } catch {
                                print("フォトライブラリ書き出し後のファイル削除失敗 : \(contentUrl.lastPathComponent)")
                            }
                        } else {
                            print("フォトライブラリ書き出し失敗 : \(contentUrl.lastPathComponent)")
                        }
                    }
                }
            }
        } catch {
            print("ファイル一覧取得エラー")
        }
    }
    
    func createIcon() {
        warnImage = UIImage(named: "DAS002")!
        warnImageView = UIImageView(image: warnImage)
        warnImageView.translatesAutoresizingMaskIntoConstraints = false
        warnImageView.contentMode = .scaleAspectFit
        view.addSubview(warnImageView)
        warnImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 520).isActive = true
        warnImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        warnImageView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
    }

}
