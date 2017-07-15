//
//  PokeDetailsVC.swift
//  pokeDex
//
//  Created by Tarek Sabry on 7/8/17.
//  Copyright © 2017 Tarek Sabry. All rights reserved.
//

import UIKit
import CoreData

class PokeDetailsVC: UIViewController {
    var poke : Poke!
    @IBOutlet var pokeDetailsView: PokeDetailsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        if(InternetChecker.sharedInstance.internetAvailable() && poke.desc == nil) {
            SwiftSpinner.show("Loading Pokemon Data..")
            let url = "http://pokeapi.co/api/v1/pokemon/\(poke.id)/"
            request(url).responseJSON {
                response in
                
                let result = response.value
                if let dict = result as? Dictionary<String,Any> {
                    if let attack = dict["attack"] as? Int {
                        self.poke.attack = Int16(attack)
                    }
                    
                    if let defense = dict["defense"] as? Int {
                        self.poke.defense = Int16(defense)
                    }
                    
                    if let weight = dict["weight"] as? String {
                        self.poke.weight = Int16(weight)!
                    }
                    if let height = dict["height"] as? String {
                        self.poke.height = Int16(height)!
                        
                    }
                    if let types = dict["types"] as? [Dictionary<String,String>] {
                        var pokemonType = ""
                        for type in types {
                            pokemonType += "\(type["name"]!.capitalized)/"
                        }
                        pokemonType.remove(at: pokemonType.index(before: pokemonType.endIndex))
                        self.poke.type = pokemonType
                    }
                    if let evolutions = dict["evolutions"] as? [Dictionary<String,Any>] {
                        var nextEvolution = ""
                        var pokemonTo = ""
                        if evolutions.count > 0 {
                            if let level = evolutions[0]["level"] as? Int {
                                pokemonTo = String(describing: evolutions[0]["to"]!)
                                nextEvolution = "\(pokemonTo) LVL \(level)"
                            } else {
                                nextEvolution = "mega"
                            }
                        } else {
                            nextEvolution = "mega"
                        }
                        if nextEvolution != "mega" {
                            let fetchRequest : NSFetchRequest<Poke> = Poke.fetchRequest()
                            fetchRequest.fetchLimit = 1
                            fetchRequest.predicate = NSPredicate(format: "name == %@", pokemonTo.lowercased())
                            do {
                                let result = try context.fetch(fetchRequest)
                                self.poke.nextEvolutionID = result[0].id
                            } catch let err as NSError {
                                print(err.debugDescription)
                            }

                        }
                         self.poke.nextEvolution = nextEvolution
                    }
                    
                  
                    
                    if let description = dict["descriptions"] as? [Dictionary<String,String>] {
                        if let firstDescription = description[0] as? Dictionary<String,String> {
                            let URI = "http://pokeapi.co\(firstDescription["resource_uri"]!)"
                            request(URI).responseJSON { response in
                                let result = response.value
                                if let dict = result as? Dictionary<String,Any> {
                                    if let description = dict["description"] as? String {
                                        self.poke.desc = description
                                    }
                                }
                                self.pokeDetailsView.configureView(poke: self.poke)
                                ad.saveContext()
                                SwiftSpinner.hide()
                            }
                        }
                    }
                }
            }
        } else if InternetChecker.sharedInstance.internetAvailable() && poke.desc != nil {
                self.pokeDetailsView.configureView(poke: poke)
        } else if(!InternetChecker.sharedInstance.internetAvailable() && poke.desc != nil) {
             self.pokeDetailsView.configureView(poke: self.poke)
        } else {
            let alert = UIAlertController(title: "It appears that there's no internet connection and the pokemon data are not stored on the phone. Please try again later", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(action)
            presentViewController(alert: alert, animated: true, completion: nil)
            
        }
    }

    private func presentViewController(alert: UIAlertController, animated flag: Bool, completion: (() -> Void)?) -> Void {
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: flag, completion: completion)
    }
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
