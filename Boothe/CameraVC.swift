//
//  CameraVC.swift
//  Boothe
//
//  Created by William  Uchegbu on 10/10/18.
//  Copyright © 2018 William  Uchegbu. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class CameraVC: UIViewController {
    var captureSession = AVCaptureSession()
    var frontCamera: AVCaptureDevice?
    var backCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var capturedImage: UIImage?
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setupDevice()
        setupCaptureSession()
        setupIO()
        setupPreviewLayer()
        startCaptureSession()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupDevice(){
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: .video, position: .unspecified)
        let devices = discoverySession.devices
        
        for device in devices {
            if device.position == .back {
                backCamera = device
            }
            else if device.position == .front {
                frontCamera = device
            }
        }
        
        currentCamera = backCamera
    }
    
    func setupCaptureSession(){
        captureSession.sessionPreset = AVCaptureSession.Preset.iFrame960x540
    }
    
    func setupIO(){
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
           photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        } catch {
            print("U Fucced up!")
        }
    }
    
    func setupPreviewLayer(){
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer?.connection?.videoOrientation = .portrait
        previewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(previewLayer!, at: 0)
    }
    
    func startCaptureSession(){
        captureSession.startRunning()
    }
    
    
    
    @IBAction func capturePhoto(_ sender: Any) {
        photoOutput?.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        /*
        if captureSession.isRunning {
            captureSession.stopRunning()
            
        }
        else {
            captureSession.startRunning()
        }*/
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PhotoPreviewVC
        vc.image = self.image
    }
    
    
    @IBAction func flipCamera(_ sender: Any) {
        backCamera?.position.rawValue
        /*
        if currentCamera == frontCamera {
        currentCamera = backCamera
        }
        else {
            currentCamera = frontCamera
        }
        */
    }
    
}

extension CameraVC: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation(){
            print(imageData)
            image = UIImage(data: imageData)
            performSegue(withIdentifier: "previewPhoto", sender: self)
        }
    }
}
