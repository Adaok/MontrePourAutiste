//
//  GroupsListViewController.swift
//  AutisteWatch
//
//  Created by iem on 01/06/2016.
//  Copyright © 2016 LP-BG-IEM. All rights reserved.
//

import UIKit

class GroupsListViewController: UITableViewController, AddElementOfTypeGroupViewControllerDelegate {
    var addGroupButton:UIBarButtonItem?
    
    let groupManager = GroupManager.sharedInstance

    var groups = [Group]()
    
    func sortGroups(){
        groups.sortInPlace({ $0.nameGroup < $1.nameGroup})
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        groups = groupManager.fetchGroups()!
        addGroupButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(self.addGroupItemAction))
        groups = groupManager.fetchGroups()!
            
        self.clearsSelectionOnViewWillAppear = false
        addGroupButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(GroupsListViewController.addGroupItemAction))
    }
    
    override func viewWillAppear(animated: Bool) {
        sortGroups()
        self.tabBarController!.title = "Groupes"
        self.tabBarController!.navigationItem.setRightBarButtonItem(addGroupButton, animated: true)
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
        return groups.count
    }
    
    // MARK: - Table View delegate
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            groupManager.deleteGroup(groups[indexPath.row])
            groups.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GroupCell", forIndexPath: indexPath)
        ((cell.viewWithTag(1)) as! UILabel).text = groups[indexPath.row].nameGroup
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == Segues.toAddGroup {
            let vc = segue.destinationViewController as! AddElementViewController
            vc.isGroup = true
            vc.groupDelegate = self
        } else if segue.identifier == Segues.toEditGroup {
            let vc = segue.destinationViewController as! AddElementViewController
            let index = tableView.indexPathForCell(sender as! UITableViewCell)
            let group = groups[index!.row]
            vc.groupToEdit = group
            vc.isGroup = true
            vc.groupDelegate = self
        }  else if segue.identifier == Segues.toPlanGroup {
            let vc = segue.destinationViewController as! PlanOrNotifyViewController
            let index = tableView.indexPathForCell(sender as! UITableViewCell)
            let group = groups[index!.row]
            vc.isGroup = true
            vc.groupToManage = group
        }
    }
    
    // MARK: - Business
    
    func addGroupItemAction () {
        performSegueWithIdentifier(Segues.toAddGroup, sender: addGroupButton)
    }
 

    // MARK: - AddElementViewControllerDelegate
    
    func addElementOfTypeGroupViewController(controller: AddElementViewController, didFinishAddingItem group: Group) {
        navigationController?.popViewControllerAnimated(true)
        groups.append(group)
        let index = groups.indexOf({ $0 === group })
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: index!, inSection: 0)], withRowAnimation: .Bottom)
    }
    
    func editElementOfTypeGroupViewController(controller: AddElementViewController, didFinishEditingItem group: Group) {
        navigationController?.popViewControllerAnimated(true)
        let index = groups.indexOf({ $0 === group })
        let indexPath = NSIndexPath(forRow: index!, inSection: 0)
        groups[index!].nameGroup = group.nameGroup
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
}
