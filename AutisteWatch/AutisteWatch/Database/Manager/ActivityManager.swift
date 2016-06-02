//
//  ActivityManager.swift
//  AutisteWatch
//
//  Created by Marco Loiodice on 31/05/2016.
//  Copyright © 2016 LP-BG-IEM. All rights reserved.
//

import UIKit
import CoreData

class ActivityManager: NSObject {
    
    static let sharedInstance = ActivityManager()
    
    var appDelegate: AppDelegate{
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    var managedObjectContext: NSManagedObjectContext{
        return appDelegate.managedObjectContext
    }
    
    func createActivity(nameActivity:String, imageActivity:Image, dateRemind:NSDate, planning:Planning?)->Activity{
        let entity = NSEntityDescription.entityForName("Activity", inManagedObjectContext: managedObjectContext)
        let activity = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext) as! Activity
        activity.nameActivity = nameActivity
        activity.rememberHourActivity = dateRemind
        activity.idImage = imageActivity.idImage
        if planning != nil{
            let plannings:NSSet
            plannings = NSSet.init(object: planning!)
            activity.relationPlanningActivity = plannings
        }
        return activity
    }
    
    func fetchActivities()->[Activity]?{
        let fetchRequest=NSFetchRequest(entityName: "Activity")
        do {
            let result = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Activity]
            return result
        } catch let error as NSError {
            print("Could not fetch Activities : \(error)")
        }
        
        return [Activity]()
    }
    
    func fetchActivitiesByPatient(patient: Patient)->[Activity]?{
        let fetchPatientRequest = NSFetchRequest(entityName: "Activity")
        let predicate = NSPredicate(format: patient.idPatient!, argumentArray: nil)
        fetchPatientRequest.predicate = predicate
        
        do {
            let result = try managedObjectContext.executeFetchRequest(fetchPatientRequest) as! [Activity]
            return result
        } catch let error as NSError {
            print("Could not fetch Activities : \(error)")
        }
        
        return [Activity]()
    }

}
