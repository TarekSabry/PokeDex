//
//  Moves+CoreDataClass.swift
//  pokeDex
//
//  Created by Tarek Sabry on 7/10/17.
//  Copyright © 2017 Tarek Sabry. All rights reserved.
//

import Foundation
import CoreData

@objc(Moves)
public class Moves: NSManagedObject {
    
    public override func awakeFromFetch() {
        super.awakeFromFetch()
        self.moveLearnType = self.moveLearnType?.capitalized
    }

}
