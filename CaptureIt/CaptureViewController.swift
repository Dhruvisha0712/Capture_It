//
//  CaptureViewController.swift
//  CaptureIt
//
//  Created by Nandan on 22/06/24.
//

import UIKit
import AVFoundation

class CaptureViewController: UIViewController {
    
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var cameraView: UIView!
    
    var session: AVCaptureSession?
    var output = AVCapturePhotoOutput()
    var previewLayer = AVCaptureVideoPreviewLayer()
    var capturedImgs = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cameraView.layer.addSublayer(previewLayer)
        checkCamPermission()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !(session?.isRunning ?? false) {
            DispatchQueue.global().async {
                self.session?.startRunning()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        previewLayer.frame = cameraView.bounds
    }
    
    private func checkCamPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard granted else { return }
                
                DispatchQueue.main.async {
                    self?.setupCam()
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            setupCam()
        @unknown default:
            break
        }
    }
    
    func setupCam() {
        let captureSession = AVCaptureSession()
        
        if let captureDevice = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                if captureSession.canAddInput(input) {
                    captureSession.addInput(input)
                }
                
                if captureSession.canAddOutput(output) {
                    captureSession.addOutput(output)
                }
                
                previewLayer.session = captureSession
                previewLayer.videoGravity = .resizeAspectFill
                
                DispatchQueue.global().async {
                    captureSession.startRunning()
                }
                self.session = captureSession
                
            } catch {
                print("failed to set device: \(error.localizedDescription)")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVc = segue.destination as! PreviewViewController
        destinationVc.delegate = self
        destinationVc.capturedImgs = capturedImgs
    }
    
    @IBAction func prevBtnPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func captureBtnPressed(_ sender: UIButton) {
        let photoSettings = AVCapturePhotoSettings()
        if let photoPreviewType = photoSettings.availablePreviewPhotoPixelFormatTypes.first {
            photoSettings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: photoPreviewType]
            output.capturePhoto(with: photoSettings, delegate: self)
        }
    }
}

extension CaptureViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else {
            return
        }
        
        let image = UIImage(data: data) ?? UIImage()
        capturedImgs.append(image)
        print("capturedImgs: \(capturedImgs)")
        
        session?.stopRunning()
        
        performSegue(withIdentifier: Consts.captureToPreviewSegue, sender: self)
    }
}

extension CaptureViewController: PreviewViewControllerDelegate {
    func backTocapture(with imgs: [UIImage]) {
        capturedImgs = imgs
    }
}
