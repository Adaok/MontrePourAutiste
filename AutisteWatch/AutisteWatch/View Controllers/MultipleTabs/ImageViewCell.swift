//
//  ImageViewCell.swift
//  AutisteWatch
//
//  Created by iem on 08/06/2016.
//
//

import UIKit

class ImageViewCell: UICollectionViewCell {
    @IBOutlet weak var imgVw_imgForAcitivity: UIImageView!
    
    
    var image: Image? {
        didSet {
            if let image = image {
                imgVw_imgForAcitivity.image = UIImage(named: image.nameImage!)
            }
        }
    }
}
