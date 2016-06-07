//
//  ActivitiesListViewController.swift
//  AutisteWatch
//
//  Created by iem on 01/06/2016.
//  Copyright © 2016 LP-BG-IEM. All rights reserved.
//

import UIKit


private let reuseIdentifier = "oneActivity"

class ActivitiesListViewController: UICollectionViewController, ActivityDetailDelegate {
    var addActivityButton: UIBarButtonItem?
    var backButton: UIBarButtonItem?
    
    var activities: [Activity]?
    var images: [Image]?
    
    let am: ActivityManager = ActivityManager.sharedInstance
    let im: ImageManager = ImageManager.sharedInstance
    
    // MARK - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        addActivityButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(self.addActivityAction))
        // Do any additional setup after loading the view.
    
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.navigationItem.setRightBarButtonItem(addActivityButton, animated: true)
        self.tabBarController?.navigationItem.title = "Activities"
        activities = am.fetchActivities()
        images = im.fetchImages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
//        return activities!.count
        if activities != nil {
            return (activities?.count)!
        } else {
            return 0
        }
        
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ActivityViewCell
        
        if activities != nil {
            cell.imgVw_activityImage.image = UIImage(contentsOfFile: images![indexPath.row].pathImage!)
            cell.lbl_activityName.text = activities![indexPath.row].nameActivity
        }
        // Configure the cell
    
        return cell
    }
    
    // MARK: Actions
    
    func addActivityAction() {
        performSegueWithIdentifier(Segues.toAddActivity, sender: self)
        
    }
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Segues.toEditActivity {
            let indexPaths = collectionView?.indexPathsForSelectedItems()
            let indexPath = indexPaths![0]
            
            let destVC: ActivityDetailViewController = segue.destinationViewController as! ActivityDetailViewController
            
            let cell = collectionView?.cellForItemAtIndexPath(indexPath) as! ActivityViewCell
            
            destVC.activityImage = cell.imgVw_activityImage.image
            destVC.activityName = cell.lbl_activityName.text
            
        }
    }

    func activityDetailViewController(controller: ActivityDetailViewController, didFinishAddingItem activity: Activity) {
        navigationController?.popViewControllerAnimated(true)
        activities?.append(activity)
        let index = activities?.indexOf({ $0 === activity })
        collectionView?.insertItemsAtIndexPaths([NSIndexPath(forRow: index!, inSection: 0)])
        
    }
    
    func activityDetailViewController(controller: ActivityDetailViewController, didFinishEditingItem activity: Activity) {
        navigationController?.popViewControllerAnimated(true)
        let index = activities?.indexOf({ $0 === activity })
        activities![index!] = activity
        collectionView?.reloadItemsAtIndexPaths([NSIndexPath(forRow: index!, inSection: 0)])
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    


}
