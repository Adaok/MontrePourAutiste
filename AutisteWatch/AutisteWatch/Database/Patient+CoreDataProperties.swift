//
//  Patient+CoreDataProperties.swift
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

extension Patient {

    @NSManaged var idPatient: String?
    @NSManaged var namePatient: String?
    @NSManaged var relationGroupPatient: NSSet?
    @NSManaged var relationPlanningPatient: Planning?

}
