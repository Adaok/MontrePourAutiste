//
//  NotifyViewController.swift
//  AutisteWatch
//
//  Created by iem on 07/06/2016.
//
//

import UIKit

class NotifyViewController: UIViewController {
    
    var patientToNotify : Patient?
    var groupToNotify : Group?
    var isPatient : Bool = false
    var isGroup : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isPatient {
            print(patientToNotify!.namePatient)
        }
        if isGroup {
            print(groupToNotify!.nameGroup)
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
