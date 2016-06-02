//
//  AddElementViewController.swift
//  AutisteWatch
//
//  Created by iem on 01/06/2016.
//  Copyright © 2016 LP-BG-IEM. All rights reserved.
//

import UIKit

class AddElementViewController: UIViewController , UITextFieldDelegate{
    
    var patientToEdit : Patient?
    var groupToEdit : Group?
    var isPatient : Bool = false
    var isGroup : Bool = false
    
    @IBOutlet weak var txtFld_elementsName: UITextField!
    
    var doneButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton = UIBarButtonItem(barButtonSystemItem: .Done , target: self, action: #selector(self.doneAction))
        doneButton.enabled = false
        
        self.navigationItem.setRightBarButtonItem(doneButton, animated: true)
        
        if isPatient {
            if patientToEdit != nil {
                self.navigationItem.title = patientToEdit?.namePatient
                txtFld_elementsName.text = patientToEdit?.namePatient
            } else {
                self.navigationItem.title = "Nouveau"
            }
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        txtFld_elementsName.becomeFirstResponder()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
                   replacementString string: String) -> Bool {
        
        let beforeText: NSString = textField.text!
        let afterText: NSString = beforeText.stringByReplacingCharactersInRange(range, withString: string)
        
        if afterText.length > 0 {
            doneButton.enabled = true
        } else {
            doneButton.enabled = false
        }
        
        return true
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doneAction(){
        if isPatient {
            if patientToEdit != nil {
            } else {
                PatientManager.sharedInstance.createPatient(txtFld_elementsName.text!, idWatch: "toto", group: nil)
            }
            navigationController?.popViewControllerAnimated(true)
        }

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
