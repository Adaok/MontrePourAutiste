//
//  ActivityViewCell.swift
//  AutisteWatch
//
//  Created by iem on 02/06/2016.
//  Copyright © 2016 LP-BG-IEM. All rights reserved.
//

import UIKit

class ActivityViewCell: UITableViewCell {
    @IBOutlet weak var imgVw_activityImage: UIImageView!
    @IBOutlet weak var lbl_activityName: UILabel!
    @IBOutlet weak var lbl_activityHour: UILabel!
    
    let dateFormat: NSDateFormatter = NSDateFormatter()
    
    var activity: Activity? {
        didSet {
            if let activity = activity {
                imgVw_activityImage.image = UIImage(named: ImageManager.sharedInstance.fetchImageById(activity.idImage!)!.nameImage!)
                print(imgVw_activityImage.image)
                lbl_activityName.text = activity.nameActivity
                print(lbl_activityName.text)
                
                dateFormat.dateFormat = "HH:mm"
                lbl_activityHour.text = dateFormat.stringFromDate(activity.rememberHourActivity!)
            }
        }
    }
}
