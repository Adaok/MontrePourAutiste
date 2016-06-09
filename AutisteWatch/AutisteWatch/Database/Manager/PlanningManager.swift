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
    
    static let sharedInstance = PlanningManager()
    
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
    
    func fetchPlanning()->[Planning]?{
        let fetchRequest=NSFetchRequest(entityName: "Planning")
        do {
            let result = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Planning]
            return result
        } catch let error as NSError {
            print("Could not fetch Plannings : \(error)")
        }
        
        return [Planning]()
    }
    
    func fetchPlanningsByPatient(patient: Patient)->[Planning]?{
        let fetchPatientRequest = NSFetchRequest(entityName: "Planning")
        let predicate = NSPredicate(format:"idPatient like %@" , patient.idPatient!)
        fetchPatientRequest.predicate = predicate
        
        do {
            let result = try managedObjectContext.executeFetchRequest(fetchPatientRequest) as! [Planning]
            return result
        } catch let error as NSError {
            print("Could not fetch Plannings by Patient : \(error)")
        }
        
        return [Planning]()
    }
    
    func fetchPlanningsByGroup(group: Group)->[Planning]?{
        let setPatients = group.relationPatientGroup
        let patients:[Patient] = setPatients?.allObjects as! [Patient]
        var planningsOfGroup = [Planning]()
        
        for var patient in patients {
            var planning = fetchPlanningsByPatient(patient)
            planningsOfGroup.append(planning![0])
        }
        
        return planningsOfGroup
    }
    
    func deletePlannings(plannings:[Planning]){
        for var planning:Planning in plannings{
            self.managedObjectContext.deleteObject(planning)
        }
        do {
            try self.managedObjectContext.save()
        } catch let error as NSError {
            print("Could not delete Planning : \(error)")
        }
    }
    
    func deleteForPatient(patient:Patient){
        var plannings:[Planning]=[]
        plannings = fetchPlanningsByPatient(patient)!
        deletePlannings(plannings)
    }
    

}
