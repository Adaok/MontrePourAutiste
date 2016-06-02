//
//  PlanningManager.swift
//  AutisteWatch
//
//  Created by Marco Loiodice on 31/05/2016.
//  Copyright © 2016 LP-BG-IEM. All rights reserved.
//

import UIKit
import CoreData

class PlanningManager: NSObject {
    
    var appDelegate: AppDelegate{
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    var managedObjectContext: NSManagedObjectContext{
        return appDelegate.managedObjectContext
    }
    
    func createPlanning(patient: Patient, activity: Activity)->Planning{
        let entity = NSEntityDescription.entityForName("Planning", inManagedObjectContext: managedObjectContext)
        let planning = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext) as! Planning
        planning.relationPatientPlanning = patient
        let activityToAdd = NSSet.init(object: activity)
        planning.relationActivityPlanning = activityToAdd
        return planning
    }
    
    func fetchPlanning()->[Planning]?{
        let fetchRequest=NSFetchRequest(entityName: "Planning")
        do {
            let result = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Planning]
            return result
        } catch let error as NSError {
            print("Could not fetch Activities : \(error)")
        }
        
        return [Planning]()
    }
    
    func fetchPlanningsByPatient(patient: Patient)->[Planning]?{
        let fetchPatientRequest = NSFetchRequest(entityName: "Planning")
        let predicate = NSPredicate(format: patient.idPatient!, argumentArray: nil)
        fetchPatientRequest.predicate = predicate
        
        do {
            let result = try managedObjectContext.executeFetchRequest(fetchPatientRequest) as! [Planning]
            return result
        } catch let error as NSError {
            print("Could not fetch Activities : \(error)")
        }
        
        return [Planning]()
    }
    

}
