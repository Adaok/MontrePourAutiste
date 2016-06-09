//
//  ActivityTableViewController.swift
//  AutisteWatch
//
//  Created by iem on 08/06/2016.
//
//

import UIKit

class ActivityTableViewController: UITableViewController, ActivityDetailDelegate {
    
    // MARK: - Attributes
    var addActivityButton: UIBarButtonItem?
    var backButton: UIBarButtonItem?
    
    var activities: [Activity]?
    var images: [Image]?
    
    let am: ActivityManager = ActivityManager.sharedInstance
    let im: ImageManager = ImageManager.sharedInstance
    
    // MARK - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        activities = am.fetchActivities()
        images = im.fetchImages()

        addActivityButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(self.addActivityAction))
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.navigationItem.setRightBarButtonItem(addActivityButton, animated: true)
        self.tabBarController?.navigationItem.title = "Activities"
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if activities != nil {
            return (activities?.count)!
        } else {
            return 0
        }
    }
    // MARK: - Actions
    
    func addActivityAction() {
        performSegueWithIdentifier(Segues.toAddActivity, sender: self)
        
    }
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Segues.toEditActivity {
            let indexPath = tableView.indexPathForSelectedRow
            
            let destVC: ActivityDetailViewController = segue.destinationViewController as! ActivityDetailViewController
            
            let cell = tableView.cellForRowAtIndexPath(indexPath!) as! ActivityViewCell
            
            destVC.activityToEdit = cell.activity
            destVC.delegate = self
            
        } else if segue.identifier == Segues.toAddActivity {
            let destVC: ActivityDetailViewController = segue.destinationViewController as! ActivityDetailViewController
            destVC.delegate = self
            
        }
    }
    
    func activityDetailViewController(controller: ActivityDetailViewController, didFinishAddingItem activity: Activity) {
        navigationController?.popViewControllerAnimated(true)
        activities?.append(activity)
        let index = activities?.indexOf({ $0 === activity })
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: index!, inSection: 0)], withRowAnimation: .Automatic)
        
    }
    
    func activityDetailViewController(controller: ActivityDetailViewController, didFinishEditingItem activity: Activity) {
        navigationController?.popViewControllerAnimated(true)
        let index = activities?.indexOf({ $0 === activity })
        activities![index!] = activity
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Cells.activityCell, forIndexPath: indexPath) as! ActivityViewCell
        
        if activities != nil {
            cell.activity = activities![indexPath.row]
        }
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
