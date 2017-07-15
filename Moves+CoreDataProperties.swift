//
//  Moves+CoreDataProperties.swift
//  pokeDex
//
//  Created by Tarek Sabry on 7/10/17.
//  Copyright © 2017 Tarek Sabry. All rights reserved.
//

import Foundation
import CoreData


extension Moves {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Moves> {
        return NSFetchRequest<Moves>(entityName: "Moves")
    }

    @NSManaged public var moveName: String?
    @NSManaged public var moveLearnType: String?
    @NSManaged public var poke: Poke?

}
