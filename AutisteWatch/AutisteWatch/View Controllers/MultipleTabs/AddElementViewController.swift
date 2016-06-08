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
    var selectedPatientsForGroup : NSSet?
    
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
            selectedPatientsForGroup = NSSet()
            if groupToEdit != nil {
                self.navigationItem.title = groupToEdit?.nameGroup
                txtFld_elementsName.text = groupToEdit?.nameGroup
            } else {
                self.navigationItem.title = "Nouveau"
            }
            tableViewElements = PatientManager.sharedInstance.fetchPatients()!
        }
        
        tbleVw_elementList.dataSource = self
        tbleVw_elementList.delegate = self
        
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
                
                groupToEdit?.relationPatientGroup? = selectedPatientsForGroup!
                
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
        let cell = tableView.dequeueReusableCellWithIdentifier(Cells.elementCell, forIndexPath: indexPath)
        let label = (cell.viewWithTag(2)) as! UILabel
        let image = (cell.viewWithTag(1)) as! UIImageView        
        if isPatient {
            let group = tableViewElements[indexPath.row] as! Group
            label.text = group.nameGroup
            image.image = UIImage(named: "WatchImageOn")
        } else if isGroup {
            let patient = tableViewElements[indexPath.row] as! Patient
            label.text = patient.namePatient
            if groupToEdit != nil {
                let containsPatient = groupToEdit?.relationPatientGroup?.containsObject(patient)
                if containsPatient! {
                    cell.accessoryType = .Checkmark
                } else {
                    cell.accessoryType = .None
                }
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        doneButton.enabled = true
        if isGroup {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            let patient = tableViewElements[indexPath.row] as! Patient
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            if groupToEdit != nil {
                if cell!.accessoryType == .Checkmark {
                    cell!.accessoryType = .None
                    let mutable = NSMutableSet.init(set: selectedPatientsForGroup!)
                    mutable.removeObject(patient)
                    selectedPatientsForGroup = mutable
                } else {
                    cell!.accessoryType = .Checkmark
                    selectedPatientsForGroup = selectedPatientsForGroup?.setByAddingObject(patient)
                }
            }
        }
    }
}
