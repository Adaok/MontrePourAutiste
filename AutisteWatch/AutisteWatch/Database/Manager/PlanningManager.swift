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
    
    func createPlanning(patient: Patient)->Planning{
        let entity = NSEntityDescription.entityForName("Planning", inManagedObjectContext: managedObjectContext)
        let planning = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext) as! Planning
        planning.relationPatientPlanning = patient
        return planning
    }

}
