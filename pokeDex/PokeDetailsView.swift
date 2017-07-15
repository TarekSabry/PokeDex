//
//  PokeDetailsView.swift
//  pokeDex
//
//  Created by Tarek Sabry on 7/10/17.
//  Copyright © 2017 Tarek Sabry. All rights reserved.
//

import UIKit
import CoreGraphics

class PokeDetailsView: UIView {

    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeDescription: UILabel!
    @IBOutlet weak var pokeType: UILabel!
    @IBOutlet weak var pokeHeight: UILabel!
    @IBOutlet weak var pokeWeight: UILabel!
    @IBOutlet weak var pokeDefense: UILabel!
    @IBOutlet weak var pokeIndex: UILabel!
    @IBOutlet weak var pokeAttack: UILabel!
    @IBOutlet weak var nextEvolution: UILabel!
    @IBOutlet weak var pokemonBeforeEvolution: UIImageView!
    @IBOutlet weak var pokemonAfterEvolution: UIImageView!
    
    
    func configureView(poke : Poke) {
        pokeImage.image = UIImage(named: "\(poke.id)")
        pokeDescription.text = poke.desc
        pokeType.text = poke.type
        pokeHeight.text = "\(poke.height)"
        pokeWeight.text = "\(poke.weight)"
        pokeIndex.text = "\(poke.id)"
        pokeAttack.text = "\(poke.attack)"
        pokeDefense.text = "\(poke.defense)"
        if poke.nextEvolution! != "mega" {
            nextEvolution.text = "Next Evolution: \(poke.nextEvolution!)"
        } else {
            nextEvolution.text = "Pokemon has no evolution"
        }
        if(poke.nextEvolutionID != 0) {
            pokemonBeforeEvolution.image = UIImage(named: "\(poke.id)")
            pokemonAfterEvolution.image = UIImage(named: "\(poke.nextEvolutionID)")
        } else {
            pokemonBeforeEvolution.image = UIImage(named: "\(poke.id)")
            pokemonAfterEvolution.image = UIImage()
        }
        
    }

}
