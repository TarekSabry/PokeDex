//
//  PokeCell.swift
//  pokeDex
//
//  Created by Tarek Sabry on 7/7/17.
//  Copyright © 2017 Tarek Sabry. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ pokemon : Poke) {
        pokeLabel.text = pokemon.name
        pokeImage.image = UIImage(named: "\(pokemon.id)")
    }
    
}
