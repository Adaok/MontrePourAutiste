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
class ActivityDetailViewController: UIViewController,SelectImageViewControllerDelegate {
    // MARK: - Outlets
    @IBOutlet weak var imgVw_activityImg: UIImageView!
    @IBOutlet weak var txtFld_activityName: UITextField!
    @IBOutlet weak var datePck_activityHour: UIDatePicker!
    @IBOutlet weak var sw_forAll: UISwitch!
    
    var saveButton: UIBarButtonItem!
    var chooseImgAction: UITapGestureRecognizer!
    
    // MARK: - Attributes
    var delegate: ActivityDetailDelegate?
    
    var activityToEdit: Activity?
    var image: Image?
    
    let im: ImageManager = ImageManager.sharedInstance
    let pm: PlanningManager = PlanningManager.sharedInstance
    let pam: PatientManager = PatientManager.sharedInstance
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(saveAction))
        
        self.navigationItem.rightBarButtonItem = saveButton
        
        
        
        imgVw_activityImg.userInteractionEnabled = true
        chooseImgAction = UITapGestureRecognizer(target: self, action: #selector(self.chooseImg))
        imgVw_activityImg.gestureRecognizers = [chooseImgAction]
        
        if activityToEdit != nil {
            image = im.fetchImageById((activityToEdit?.idImage)!)
            self.imgVw_activityImg.image = UIImage(named: (image?.nameImage!)!)
            self.txtFld_activityName.placeholder = activityToEdit!.nameActivity
            self.datePck_activityHour.date = activityToEdit!.rememberHourActivity!
            
            self.navigationItem.title = activityToEdit!.nameActivity
        } else {
            self.imgVw_activityImg.image = UIImage(named: "No Activity")
            self.txtFld_activityName.placeholder = "Veuillez entrer le nom de l'activité"
//            activityToEdit = Activity()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Actions
    
    func chooseImg() {
        self.performSegueWithIdentifier(Segues.toImageListActivity, sender: self)
    }
    
    func saveAction() {
        if activityToEdit != nil {
            activityToEdit?.idImage = image?.idImage
            if txtFld_activityName.text != "" {
                activityToEdit?.nameActivity = txtFld_activityName.text
            }
            activityToEdit?.rememberHourActivity = datePck_activityHour.date

            delegate?.activityDetailViewController(self, didFinishEditingItem: activityToEdit!)
        } else {
            activityToEdit = ActivityManager.sharedInstance.createActivity(txtFld_activityName.text!, imageActivity: image!, dateRemind: datePck_activityHour.date, planning: nil)

            delegate?.activityDetailViewController(self, didFinishAddingItem: activityToEdit!)
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Segues.toImageListActivity {
            let destVC = segue.destinationViewController as! ImageListViewController
            destVC.delegate = self
        }
    }
    
    
    // MARK: - Delegate
    
    func selectImageViewController(controller: ImageListViewController, didFinishSelectingItem image: Image) {
        navigationController?.popViewControllerAnimated(true)
        self.imgVw_activityImg.image  = UIImage(named: image.nameImage!)
        self.image = image
        
    }

}
