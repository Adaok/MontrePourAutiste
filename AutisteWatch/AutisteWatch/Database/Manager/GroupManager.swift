//
//  GroupManager.swift
//  AutisteWatch
//
//  Created by Marco Loiodice on 31/05/2016.
//  Copyright © 2016 LP-BG-IEM. All rights reserved.
//

import UIKit
import CoreData

class GroupManager: NSObject {
    
    static let sharedInstance = GroupManager()

    var appDelegate: AppDelegate{
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    var managedObjectContext: NSManagedObjectContext{
        return appDelegate.managedObjectContext
    }
    
    func createGroup(groupName: String, patients:[Patient]?)->Group{
        let entity = NSEntityDescription.entityForName("Group", inManagedObjectContext: managedObjectContext)
        let group = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext) as! Group
        group.nameGroup=groupName
        if patients != nil {
            let patientsToAdd:NSSet
            patientsToAdd = NSSet.init(array: patients!)
            group.relationPatientGroup = patientsToAdd
        }
        
        do {
            try self.managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save group : \(error)")
        }
        
        return group
    }
    
    func fetchGroups()->[Group]?{
        let fetchRequest = NSFetchRequest(entityName: "Group")
        let sortDescriptor = NSSortDescriptor(key: "nameGroup", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do{
            let result = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Group]
            return result
        } catch let error as NSError {
            print("Could not fetch Groups : \(error)")
        }
        
        return [Group]()
    }
    
    func addPatientsToGroup(patients:[Patient], group: Group)->Group{
        let patientsSelected = NSSet.init(array: patients)
        group.relationPatientGroup = patientsSelected
        return group
    }
    
    func deleteGroup(group: Group){
        self.managedObjectContext.deleteObject(group)
        do {
            try self.managedObjectContext.save()
        } catch let error as NSError {
            print("Could not delete Group : \(error)")
        }
    }
}
