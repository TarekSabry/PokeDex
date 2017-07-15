//
//  MovesVC.swift
//  pokeDex
//
//  Created by Tarek Sabry on 7/10/17.
//  Copyright © 2017 Tarek Sabry. All rights reserved.
//

import UIKit

class MovesVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var poke : Poke!
    var movesArray = [Moves]()
    @IBOutlet weak var movesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movesTableView.separatorStyle = .none
        if(poke.moves?.count == 0) {
            request("http://pokeapi.co/api/v1/pokemon/\(poke.id)").responseJSON {
                response in
                let result = response.value
                if let dict = result as? Dictionary<String,Any> {
                    if let moves = dict["moves"] as? [Dictionary<String,Any>] {
                        for move in moves {
                            let pokeMove = Moves(context: context)
                            pokeMove.moveName = move["name"] as? String
                            pokeMove.moveLearnType = move["learn_type"] as? String
                            self.poke.addToMoves(pokeMove)
                        }
                    }
                }
                ad.saveContext()
                self.movesTableView.reloadData()
            }
        }
        movesTableView.delegate = self
        movesTableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.poke.moves!.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moveCell", for: indexPath) as! MovesCell
        if let tempArray = poke.moves {
            movesArray = tempArray.allObjects as! [Moves]
        }
        cell.configureCell(move: movesArray[indexPath.row])
        return cell
        
    }
}
