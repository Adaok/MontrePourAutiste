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

    
    // MARK: - Table View Delegate
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Cells.activityCell, forIndexPath: indexPath) as! ActivityViewCell
        
        if activities != nil {
            cell.activity = activities![indexPath.row]
        }
        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            am.deleteActivities([activities![indexPath.row]])
            activities?.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
}
