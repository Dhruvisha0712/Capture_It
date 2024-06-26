//
//  PreviewViewController.swift
//  CaptureIt
//
//  Created by Nandan on 22/06/24.
//

import UIKit

protocol PreviewViewControllerDelegate {
    func backTocapture(with imgs: [UIImage])
}

class PreviewViewController: UIViewController {

    @IBOutlet weak var previewImgView: UIImageView!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var capturedImgs = [UIImage]()
    var delegate: PreviewViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("MyVariables.currentPhotoCount: \(MyVariables.currentPhotoCount)")
        previewImgView.image = capturedImgs[MyVariables.currentPhotoCount]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVc = segue.destination as! GalleryViewController
        destinationVc.imgs = capturedImgs
    }

    @IBAction func prevBtnPressed(_ sender: UIButton) {
        capturedImgs.remove(at: MyVariables.currentPhotoCount)
        delegate?.backTocapture(with: capturedImgs)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtnPressed(_ sender: UIButton) {
        MyVariables.currentPhotoCount += 1
        
        if MyVariables.currentPhotoCount == MyVariables.noOfPhotos {
            performSegue(withIdentifier: Consts.previewToGallerySegue, sender: self)
        } else {
            delegate?.backTocapture(with: capturedImgs)
            navigationController?.popViewController(animated: true)
        }
    }
}
