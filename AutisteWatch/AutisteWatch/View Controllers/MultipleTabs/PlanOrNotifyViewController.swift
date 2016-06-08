//
//  PlanOrNotifyViewController.swift
//  AutisteWatch
//
//  Created by iem on 01/06/2016.
//  Copyright © 2016 LP-BG-IEM. All rights reserved.
//

import UIKit

class PlanOrNotifyViewController: UIViewController {
    
    var patientToManage : Patient?
    var groupToManage : Group?
    var isPatient : Bool = false
    var isGroup : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isPatient {
            let name : String = patientToManage!.namePatient!
            self.navigationItem.title = "Gérer \(name)"
        } else if isGroup {
            let nameGroup: String = groupToManage!.nameGroup!
            self.navigationItem.title = "Gérer \(nameGroup)"
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == Segues.toPlanning {
            let vc = segue.destinationViewController as! PlanningViewController
            if isPatient {
                vc.isPatient = true
                vc.patientToDisplayPlanning = patientToManage
            } else if isGroup {
                vc.isGroup = true
                vc.groupToDisplayPlanning = groupToManage
            }
        } else if segue.identifier == Segues.toNotify {
            let vc = segue.destinationViewController as! NotifyViewController
            if isPatient {
                vc.isPatient = true
                vc.patientToNotify = patientToManage
            } else if isGroup {
                vc.isGroup = true
                vc.groupToNotify = groupToManage
            }
        }
        
    }

}
