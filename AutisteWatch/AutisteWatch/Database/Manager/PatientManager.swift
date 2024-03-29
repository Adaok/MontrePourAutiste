//
//  PatientManager.swift
//  AutisteWatch
//
//  Created by Marco Loiodice on 31/05/2016.
//  Copyright © 2016 LP-BG-IEM. All rights reserved.
//

import UIKit
import CoreData

class PatientManager: NSObject {
    
    static let sharedInstance = PatientManager()
    
    var appDelegate: AppDelegate{
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    var managedObjectContext: NSManagedObjectContext{
        return appDelegate.managedObjectContext
    }
    
    func createPatient(name:String, idWatch:String, group:Group?)->Patient{
        let entity = NSEntityDescription.entityForName("Patient", inManagedObjectContext: managedObjectContext)
        let patient = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext) as! Patient
        patient.namePatient = name
        patient.idPatient = idWatch
        if group != nil{
            let groups:NSSet
            groups = NSSet.init(object: group!)
            patient.relationGroupPatient = groups
        }

        do {
            try self.managedObjectContext.save()
        } catch let error as NSError {
            print("Could not delete Patient : \(error)")
        }
        return patient
    }
    
    func fetchPatients()->[Patient]?{
        let fetchRequest = NSFetchRequest(entityName: "Patient")
        let sortDescriptor = NSSortDescriptor(key: "namePatient", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do{
            let result = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Patient]
            return result
        } catch let error as NSError {
            print("Could not fetch Groups : \(error)")
        }
        
        return [Patient]()
    }
    
    func addGroupsToPatient(patient:Patient, groups: [Group])->Patient{
        let groupsSelected = NSSet.init(array: groups)
        patient.relationGroupPatient = groupsSelected
        return patient
    }
    
    func deletePatient(patient:Patient){
        self.managedObjectContext.deleteObject(patient)
        do {
            try self.managedObjectContext.save()
        } catch let error as NSError {
            print("Could not delete Patient : \(error)")
        }
    }
    

}
