//
//  movesCell.swift
//  pokeDex
//
//  Created by Tarek Sabry on 7/10/17.
//  Copyright © 2017 Tarek Sabry. All rights reserved.
//

import UIKit

class MovesCell: UITableViewCell {
    
    func configureCell(move : Moves) {
        self.textLabel?.text = "Move : \(move.moveName!)"
        self.detailTextLabel!.text = "Learn Type : \(move.moveLearnType!)"
        
    }

}
