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
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        camera.wantsLayer = true
        camera.layer?.backgroundColor = .black
        captureSession.sessionPreset = AVCaptureSession.Preset.low
        let input: AVCaptureDeviceInput
        do {
            input = try AVCaptureDeviceInput(device: AVCaptureDevice.default(for: .video)!)
        } catch {
            dialogOKCancel(question: "Cannot open camera!", text: "The app will not terminate")
            exit(1)
        }
        captureSession.addInput(input)
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
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
    
    func dialogOKCancel(question: String, text: String) {
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.alertStyle = .critical
        alert.addButton(withTitle: "OK")
    }
    
    @IBAction func flipClicked(_ sender: NSButton) {
        if let connection = previewLayer.connection {
            connection.automaticallyAdjustsVideoMirroring = false
            if connection.isVideoMirroringSupported {
                connection.isVideoMirrored = !connection.isVideoMirrored
            }
        }
    }
}
