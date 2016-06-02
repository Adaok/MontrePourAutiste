//
//  ActivityViewCell.swift
//  AutisteWatch
//
//  Created by iem on 02/06/2016.
//  Copyright © 2016 LP-BG-IEM. All rights reserved.
//

import UIKit

class ActivityViewCell: UICollectionViewCell {
    @IBOutlet weak var imgVw_activityImage: UIImageView!
    @IBOutlet weak var lbl_activityName: UILabel!
    
    var activity: Activity? {
        didSet {
            if let activity = activity {
//                imgVw_activityImage.image = UIImage(contentsOfFile: activity.)
                lbl_activityName.text = activity.nameActivity
            }
        }
    }
}
