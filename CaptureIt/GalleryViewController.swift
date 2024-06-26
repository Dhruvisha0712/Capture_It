//
//  GalleryViewController.swift
//  CaptureIt
//
//  Created by Nandan on 22/06/24.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var imgsCollectionView: UICollectionView!
    @IBOutlet weak var zoomView: UIView!
    @IBOutlet weak var zoomImgView: UIImageView!
    @IBOutlet weak var zoomViewCloseBtn: UIButton!
    @IBOutlet weak var blackBtn: UIButton!
    
    var imgs = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        zoomView.isHidden = true
        blackBtn.isHidden = true
        zoomView.layer.cornerRadius = 10
        zoomImgView.layer.cornerRadius = 10
        zoomViewCloseBtn.layer.cornerRadius = 15
        
        imgsCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        imgsCollectionView.delegate = self
        imgsCollectionView.dataSource = self
        imgsCollectionView.register(UINib(nibName: Consts.imgsCollectionViewCellNibName, bundle: nil), forCellWithReuseIdentifier: Consts.imgsCollectionViewCellReuseId)
    }
    
    @IBAction func blackBtnPressed(_ sender: UIButton) {
        zoomView.isHidden = true
        blackBtn.isHidden = true
    }
    
    @IBAction func prevBtnPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Consts.imgsCollectionViewCellReuseId, for: indexPath) as! ImgsCollectionViewCell
        
        cell.imgView.image = imgs[indexPath.item]
        
        return cell
    }
}

extension GalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        zoomImgView.image = imgs[indexPath.item]
        blackBtn.isHidden = false
        zoomView.isHidden = false
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.width / 3) - 15, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
}
