//
//  AddElementViewController.swift
//  AutisteWatch
//
//  Created by iem on 01/06/2016.
//  Copyright © 2016 LP-BG-IEM. All rights reserved.
//

import UIKit

class AddElementViewController: UIViewController {
    
    var patientToEdit : Patient?
    var groupToEdit : Group?
    var isPatient : Bool = false
    var isGroup : Bool = false
    
    @IBOutlet weak var txtFld_elementsName: UITextField!
    var donebutton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        donebutton = UIBarButtonItem(barButtonSystemItem: .Done , target: self, action: #selector(self.doneAction))
        donebutton.enabled = false
        
        self.navigationItem.setRightBarButtonItem(donebutton, animated: true)
        
        if isPatient {
            if patientToEdit != nil {
                self.navigationItem.title = patientToEdit?.namePatient
            } else {
                self.navigationItem.title = "Nouveau"
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doneAction(){
        
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
