//
//  ActivityDetailViewController.swift
//  AutisteWatch
//
//  Created by iem on 01/06/2016.
//  Copyright © 2016 LP-BG-IEM. All rights reserved.
//

import UIKit

class ActivityDetailViewController: UIViewController {

    @IBOutlet weak var imgVw_activityImg: UIImageView!
    @IBOutlet weak var txtFld_activityName: UITextField!
    
    var activityImage: UIImage!
    var activityName: String!
    
    var activityToEdit: Activity?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgVw_activityImg.image = activityImage
        txtFld_activityName.placeholder = activityName
        
        if activityToEdit != nil {
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
