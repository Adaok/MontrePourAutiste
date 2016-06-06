//
//  AddElementViewController.swift
//  AutisteWatch
//
//  Created by iem on 01/06/2016.
//  Copyright © 2016 LP-BG-IEM. All rights reserved.
//

import UIKit

protocol AddElementOfTypePatientViewControllerDelegate : class {
    
    func addElementOfTypePatientViewController(controller: AddElementViewController, didFinishAddingItem patient: Patient)
    func editElementOfTypePatientViewController(controller: AddElementViewController, didFinishEditingItem patient: Patient)
}

protocol AddElementOfTypeGroupViewControllerDelegate : class {
    
    func addElementOfTypeGroupViewController(controller: AddElementViewController, didFinishAddingItem group: Group)
    func editElementOfTypeGroupViewController(controller: AddElementViewController, didFinishEditingItem group: Group)
}

class AddElementViewController: UIViewController , UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tbleVw_elementList: UITableView!
    @IBOutlet weak var txtFld_elementsName: UITextField!
    
    var patientToEdit : Patient?
    var groupToEdit : Group?
    var isPatient : Bool = false
    var isGroup : Bool = false
    var patientDelegate : AddElementOfTypePatientViewControllerDelegate?
    var groupDelegate : AddElementOfTypeGroupViewControllerDelegate?
    var tableViewElements = [AnyObject]()
    
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
            tableViewElements = GroupManager.sharedInstance.fetchGroups()!
        } else if isGroup {
            if groupToEdit != nil {
                self.navigationItem.title = groupToEdit?.nameGroup
                txtFld_elementsName.text = groupToEdit?.nameGroup
            } else {
                self.navigationItem.title = "Nouveau"
            }
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        txtFld_elementsName.becomeFirstResponder()
    }
    
    // MARK: Business
    
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
                patientToEdit?.namePatient = txtFld_elementsName.text
                patientDelegate?.editElementOfTypePatientViewController(self, didFinishEditingItem: patientToEdit!)
            } else {
                let patient = PatientManager.sharedInstance.createPatient(txtFld_elementsName.text!, idWatch: "", group: nil)
                patientDelegate?.addElementOfTypePatientViewController(self, didFinishAddingItem: patient)
            }
        } else if isGroup {
            if groupToEdit != nil {
                groupToEdit?.nameGroup = txtFld_elementsName.text
                groupDelegate?.editElementOfTypeGroupViewController(self, didFinishEditingItem: groupToEdit!)
            } else {
                let group = GroupManager.sharedInstance.createGroup(txtFld_elementsName.text!, patients: nil)
                groupDelegate?.addElementOfTypeGroupViewController(self, didFinishAddingItem: group)
            }
        }
    }
    
    // MARK: TableView DataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return tableViewElements.count
    }
    
    // MARK: TableViewDelegate
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PatientsCell", forIndexPath: indexPath)
        ((cell.viewWithTag(2)) as! UILabel).text = tableViewElements[indexPath.row].namePatient
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
