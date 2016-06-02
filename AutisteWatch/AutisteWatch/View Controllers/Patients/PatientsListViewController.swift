//
//  PatientsListViewController.swift
//  AutisteWatch
//
//  Created by iem on 01/06/2016.
//  Copyright © 2016 LP-BG-IEM. All rights reserved.
//

import UIKit

class PatientsListViewController: UITableViewController {

    var manager = PatientManager()
    
    var patients = [Patient]()
    
    lazy var addPatientButton : UIBarButtonItem = {
        var button = UIBarButtonItem()
        button.title = "+"
        button.target = self
        button.action = #selector(PatientsListViewController.addPatientItemAction)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.createPatient("Jean-Eude", idWatch: "toto", group: nil)
        patients = manager.fetchPatients()!
        
        self.clearsSelectionOnViewWillAppear = false
        print()
        self.navigationController!.title = "Patients"
        self.navigationController!.navigationItem.setRightBarButtonItem(addPatientButton, animated: true)
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
        ((cell.viewWithTag(1)) as! UILabel).text = patients[indexPath.row].namePatient
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    // MARK: - Business
    
    func addPatientItemAction(){
        
    }
    
    

}
