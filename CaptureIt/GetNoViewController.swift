//
//  ViewController.swift
//  CaptureIt
//
//  Created by Nandan on 22/06/24.
//

import UIKit
import Toast

class GetNoViewController: UIViewController {

    @IBOutlet weak var noOfPhotoTextField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nextBtn.layer.cornerRadius = 15
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MyVariables.currentPhotoCount = 0
        MyVariables.noOfPhotos = 0
    }

    @IBAction func nextBtnPressed(_ sender: UIButton) {
        if let text = noOfPhotoTextField.text, noOfPhotoTextField.text != "" {
            MyVariables.noOfPhotos = Int(text) ?? 1
            performSegue(withIdentifier: Consts.getNoToCaptureSegue, sender: self)
        } else {
            view.makeToast("Please enter number of photos.")
        }
    }
}

extension UIViewController {
    struct MyVariables {
        static var noOfPhotos = 0
        static var currentPhotoCount = 0
    }
}
