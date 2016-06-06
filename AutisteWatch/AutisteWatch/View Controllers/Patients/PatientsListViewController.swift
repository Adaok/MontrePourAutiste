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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.createPatient("Jack", idWatch: "JackWatch", group: nil)
        
        self.clearsSelectionOnViewWillAppear = false
        
        addPatientButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add , target: self, action: #selector(PatientsListViewController.addPatientItemAction))

    }
    
    override func viewWillAppear(animated: Bool) {
        manager.sortPatients()
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
        return manager.patients.count
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
            planningManager.deleteForPatient(manager.patients[indexPath.row])
            manager.deletePatient(manager.patients[indexPath.row])
            manager.patients.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
    }

    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PatientCell", forIndexPath: indexPath)
        ((cell.viewWithTag(1)) as! UILabel).text = manager.patients[indexPath.row].namePatient
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
            let patient = manager.patients[index!.row]
            vc.patientToEdit = patient
            vc.isPatient = true
            vc.patientDelegate = self
        }
    }
    
    // MARK: - Business
    
    func addPatientItemAction(){
        performSegueWithIdentifier(Segues.toAddPatient, sender: addPatientButton)
    }
    
    // MARK: - AddElementViewControllerDelegate
    
    func addElementOfTypePatientViewController(controller: AddElementViewController, didFinishAddingItem patient: Patient) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func editElementOfTypePatientViewController(controller: AddElementViewController, didFinishEditingItem patient: Patient) {
        navigationController?.popViewControllerAnimated(true)
        let index = manager.patients.indexOf({ $0 === patient })
        let indexPath = NSIndexPath(forRow: index!, inSection: 0)
        manager.patients[index!].namePatient = patient.namePatient
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    

}
