//
//  TopView.swift
//  pokeDex
//
//  Created by Tarek Sabry on 7/10/17.
//  Copyright © 2017 Tarek Sabry. All rights reserved.
//

import UIKit

class TopView: UIView {
    @IBOutlet weak var pokemonLabel : UILabel!
    func configureLabel(text : String)
    {
        pokemonLabel.text = text
    }
    

}
