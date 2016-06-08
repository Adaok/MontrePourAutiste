//
//  PatientsListViewController.swift
//  AutisteWatch
//
//  Created by iem on 01/06/2016.
//  Copyright © 2016 LP-BG-IEM. All rights reserved.
//

import UIKit

class PatientsListViewController: UITableViewController, AddElementOfTypePatientViewControllerDelegate {

    var manager = PatientManager.sharedInstance
    
    var addPatientButton = UIBarButtonItem()
    
    var patients = [Patient]()
    
    func sortPatients(){
        patients.sortInPlace({ $0.namePatient < $1.namePatient})
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        patients = manager.fetchPatients()!
        addPatientButton = UIBarButtonItem(barButtonSystemItem: .Add , target: self, action: #selector(self.addPatientItemAction))
        
        if self.checkFirstLaunch() {
            self.setImageDatabase()
        }
        
        self.clearsSelectionOnViewWillAppear = false

    }
    
    override func viewWillAppear(animated: Bool) {
        sortPatients()
        self.tabBarController!.title = "Patients"
        self.tabBarController!.navigationItem.setRightBarButtonItem(addPatientButton, animated: true)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patients.count
    }
    
    // MARK: - Table View Delegate
    
    //Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
 
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            let planningManager = PlanningManager()
            planningManager.deleteForPatient(patients[indexPath.row])
            manager.deletePatient(patients[indexPath.row])
            patients.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PatientCell", forIndexPath: indexPath)
        ((cell.viewWithTag(1)) as! UILabel).text = patients[indexPath.row].namePatient
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == Segues.toAddPatient {
            let vc = segue.destinationViewController as! AddElementViewController
            vc.isPatient = true
            vc.patientDelegate = self
        } else if segue.identifier == Segues.toEditPatient {
            let vc = segue.destinationViewController as! AddElementViewController
            let index = tableView.indexPathForCell(sender as! UITableViewCell)
            let patient = patients[index!.row]
            vc.patientToEdit = patient
            vc.isPatient = true
            vc.patientDelegate = self
        } else if segue.identifier == Segues.toPlanPatient {
            let vc = segue.destinationViewController as! PlanOrNotifyViewController
            let index = tableView.indexPathForCell(sender as! UITableViewCell)
            let patient = patients[index!.row]
            vc.isPatient = true
            vc.patientToManage = patient
        }
        
    }
    
    // MARK: - Business
    
    func addPatientItemAction(){
        performSegueWithIdentifier(Segues.toAddPatient, sender: addPatientButton)
    }
    
    // MARK: - AddElementViewControllerDelegate
    
    func addElementOfTypePatientViewController(controller: AddElementViewController, didFinishAddingItem patient: Patient) {
        navigationController?.popViewControllerAnimated(true)
        patients.append(patient)
        let index = patients.indexOf({ $0 === patient })
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: index!, inSection: 0)], withRowAnimation: .Bottom)
    }
    
    func editElementOfTypePatientViewController(controller: AddElementViewController, didFinishEditingItem patient: Patient) {
        navigationController?.popViewControllerAnimated(true)
        let index = patients.indexOf({ $0 === patient })
        let indexPath = NSIndexPath(forRow: index!, inSection: 0)
        patients[index!].namePatient = patient.namePatient
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    // MARK First Launch
    
    private func checkFirstLaunch() -> Bool {
        var isFirstLaunch: Bool = false
        NSUserDefaults.standardUserDefaults().registerDefaults(["FirstLaunch": true])
        
        if NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch") {
            isFirstLaunch = true
        }
        return isFirstLaunch
    }
    
    private func setImageDatabase() {
        let imagesNames: [String] = ["Bed", "Bicycle", "Car", "Chocolate", "Eat", "Glass", "High school", "Home", "Laptop", "No Activity", "School bus", "Shower", "Soccer", "Tooth brush"]
        
        for i in 0..<imagesNames.count {
            ImageManager.sharedInstance.createImage(i, nameImage: imagesNames[i], pathImage: "")
        }
    }

}
