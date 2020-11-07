//
//  ViewController.swift
//  Real Image
//
//  Created by John Choi on 8/28/20.
//  Copyright © 2020 John Choi. All rights reserved.
//

import Cocoa
import AVFoundation

class ViewController: NSViewController {
    
    @IBOutlet weak var camera: NSView!
    
    let captureSession = AVCaptureSession()
    var captureDevice : AVCaptureDevice?
    var previewLayer : AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        camera.wantsLayer = true
        camera.layer?.backgroundColor = .black
        captureSession.sessionPreset = AVCaptureSession.Preset.low
        let input = try! AVCaptureDeviceInput(device: AVCaptureDevice.default(for: .video)!)
        captureSession.addInput(input)
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = camera.bounds
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        camera.layer?.addSublayer(previewLayer)
        
        
    }
    
    override func viewDidAppear() {
        self.view.window?.title = "Real Image 📷"
        captureSession.startRunning()
    }
    
    override func viewDidDisappear() {
        captureSession.stopRunning()
    }
    
}
