//
//  Poke+CoreDataProperties.swift
//  pokeDex
//
//  Created by Tarek Sabry on 7/10/17.
//  Copyright © 2017 Tarek Sabry. All rights reserved.
//

import Foundation
import CoreData


extension Poke {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Poke> {
        return NSFetchRequest<Poke>(entityName: "Poke")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var height: Int16
    @NSManaged public var weight: Int16
    @NSManaged public var defense: Int16
    @NSManaged public var attack: Int16
    @NSManaged public var type: String?
    @NSManaged public var desc: String?
    @NSManaged public var nextEvolution: String?
    @NSManaged public var nextEvolutionID: Int16
    @NSManaged public var moves: NSSet?

}

// MARK: Generated accessors for moves
extension Poke {

    @objc(addMovesObject:)
    @NSManaged public func addToMoves(_ value: Moves)

    @objc(removeMovesObject:)
    @NSManaged public func removeFromMoves(_ value: Moves)

    @objc(addMoves:)
    @NSManaged public func addToMoves(_ values: NSSet)

    @objc(removeMoves:)
    @NSManaged public func removeFromMoves(_ values: NSSet)

}
