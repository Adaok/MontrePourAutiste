//
//  ActivityDetailViewController.swift
//  AutisteWatch
//
//  Created by iem on 01/06/2016.
//  Copyright © 2016 LP-BG-IEM. All rights reserved.
//

import UIKit

// MARK: -  Delegate
protocol ActivityDetailDelegate: class {
    func activityDetailViewController(controller: ActivityDetailViewController, didFinishAddingItem activity: Activity)
    func activityDetailViewController(controller: ActivityDetailViewController, didFinishEditingItem activity: Activity)
}

// MARK: - Class
class ActivityDetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var imgVw_activityImg: UIImageView!
    @IBOutlet weak var txtFld_activityName: UITextField!
    var saveButton: UIBarButtonItem!
    
    // MARK: - Attributes
    var activityImage: UIImage!
    var activityName: String!
    
    var activityToEdit: Activity?
    
    let im: ImageManager = ImageManager.sharedInstance
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        imgVw_activityImg.image = activityImage
        txtFld_activityName.placeholder = activityName
        
        if activityToEdit != nil {
            self.imgVw_activityImg.image = UIImage(named: (im.fetchImageById(activityToEdit!.idImage!)!).nameImage!)
            self.txtFld_activityName.placeholder = activityToEdit!.nameActivity
        } else {
            self.imgVw_activityImg.image = UIImage(named: "No Activity")
            self.txtFld_activityName.placeholder = "Veuillez entrer le nom de l'activité"
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
