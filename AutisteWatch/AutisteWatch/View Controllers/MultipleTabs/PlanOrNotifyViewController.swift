//
//  PlanOrNotifyViewController.swift
//  AutisteWatch
//
//  Created by iem on 01/06/2016.
//  Copyright © 2016 LP-BG-IEM. All rights reserved.
//

import UIKit

// MARK: - Delegate

protocol ManagementGroupViewControllerDelegate : class {
    func managePlanningOfTypeGroupViewController(controller: PlanOrNotifyViewController, didDisplayingGroup group: Group)
    func manageNotificationOfTypeGroupViewController(controller: PlanOrNotifyViewController, didNotifyGroup group: Group)
}

protocol ManagementPatientViewControllerDelegate : class {
    func managePlanningOfTypePatientViewController(controller: PlanOrNotifyViewController, didDiplayingPatient patient: Patient)
    func manageNotificationOfTypePatientViewController(controller: PlanOrNotifyViewController, didNotifyPatient patient: Patient)
}

// MARK: - Class

class PlanOrNotifyViewController: UIViewController {
    
    var patientToManage : Patient?
    var groupToManage : Group?
    var isPatient : Bool = false
    var isGroup : Bool = false
    var patientDelegate : ManagementPatientViewControllerDelegate?
    var groupDelegate : ManagementGroupViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isPatient {
            self.navigationItem.title = "Gérer le groupe"
        } else if isGroup {
            self.navigationItem.title = "Gérer \(patientToManage!.namePatient)"
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Buttons Actions
    
    func planningAction(){
        
    }
    
    func notifyAction(){
        
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
