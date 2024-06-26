//
//  ImgsCollectionViewCell.swift
//  CaptureIt
//
//  Created by Nandan on 22/06/24.
//

import UIKit

class ImgsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgView.layer.cornerRadius = 10
        imgView.layer.borderWidth = 0.2
        imgView.layer.borderColor = UIColor.lightGray.cgColor
    }

}
