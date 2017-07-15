//
//  Poke+CoreDataClass.swift
//  pokeDex
//
//  Created by Tarek Sabry on 7/10/17.
//  Copyright © 2017 Tarek Sabry. All rights reserved.
//

import Foundation
import CoreData

@objc(Poke)
public class Poke: NSManagedObject {

    public override func awakeFromFetch() {
        super.awakeFromFetch()
        self.name = self.name?.capitalized
    }
    
}
