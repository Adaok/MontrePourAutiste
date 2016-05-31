//
//  Planning+CoreDataProperties.swift
//  AutisteWatch
//
//  Created by Marco Loiodice on 31/05/2016.
//  Copyright © 2016 LP-BG-IEM. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Planning {

    @NSManaged var idActivity: NSNumber?
    @NSManaged var idPatient: NSNumber?
    @NSManaged var idImage: NSNumber?
    @NSManaged var relationActivityPlanning: NSSet?
    @NSManaged var relationPatientPlanning: NSManagedObject?

}
