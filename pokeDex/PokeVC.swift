//
//  ViewController.swift
//  pokeDex
//
//  Created by Tarek Sabry on 7/7/17.
//  Copyright © 2017 Tarek Sabry. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation


class PokeVC : UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,NSFetchedResultsControllerDelegate,UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokeCollectionView: UICollectionView!
    var pokemons : [Poke]!
    var filteredPokemons = [Poke]()
    var inSearchMode = false
    var FRC : NSFetchedResultsController<Poke>!
    var AudioPlayer : AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        pokeCollectionView.delegate = self
        pokeCollectionView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if !launchedBefore {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            fillCoreData()
        }
        fetchRequest()
        playSound()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as! PokeCell
        if inSearchMode {
            cell.configureCell(filteredPokemons[indexPath.row])
        } else {
            cell.configureCell(pokemons[indexPath.row])
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemons.count
        }
        return pokemons.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if inSearchMode {
            performSegue(withIdentifier: "PokeDetailsVC", sender: filteredPokemons[indexPath.row])
        } else {
            performSegue(withIdentifier: "PokeDetailsVC", sender: pokemons[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            inSearchMode = false
            pokeCollectionView.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            let lowercase = searchBar.text!.lowercased()
            filteredPokemons = pokemons.filter({$0.name?.lowercased().range(of: lowercase) != nil })
            pokeCollectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    @IBAction func muicButtonPressed(_ sender: UIButton) {
        if AudioPlayer.isPlaying {
            AudioPlayer.pause()
            sender.alpha = 0.5
        } else {
            AudioPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokeDetailsVC" {
            if let destination = segue.destination as? ContainerVC {
                if let poke = sender as? Poke {
                    destination.poke = poke
                }
            }
        }
    }
    
    func playSound() {
        
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        do {
            AudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            AudioPlayer.numberOfLoops = -1
            AudioPlayer.prepareToPlay()
            AudioPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
    }
    
    func fillCoreData() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        do {
            let csv = try CSV(contentsOfURL: path)
            for obj in csv.rows {
                let pokeID = Int16(obj["id"]!)!
                let pokeName = obj["identifier"]!
                let pokemon = Poke(context: context)
                pokemon.id = pokeID
                pokemon.name = pokeName
                ad.saveContext()
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func fetchRequest() {
        let fetchRequest : NSFetchRequest<Poke> = Poke.fetchRequest()
        let fetchRequestDescriptors : NSSortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [fetchRequestDescriptors]
        do {
            pokemons = try context.fetch(fetchRequest)
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
    }
}

