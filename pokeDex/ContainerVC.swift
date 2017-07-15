//
//  containerVC.swift
//  pokeDex
//
//  Created by Tarek Sabry on 7/10/17.
//  Copyright © 2017 Tarek Sabry. All rights reserved.
//

import UIKit
import CoreData
class ContainerVC: UIViewController {
    var poke : Poke!
    @IBOutlet weak var topView: TopView!
    @IBOutlet weak var firstContainer: UIView!
    @IBOutlet weak var secondContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        secondContainer.isHidden = true
        topView.configureLabel(text: poke.name!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "firstSegue" {
           
            if let destination = segue.destination as? PokeDetailsVC {
                destination.poke = poke
            }
        } else if segue.identifier == "secondSegue" {
            if let destination = segue.destination as? MovesVC {
                destination.poke = poke
            }
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0 :
            secondContainer.isHidden = true
            firstContainer.isHidden = false
            break
        case 1 :
            secondContainer.isHidden = false
            firstContainer.isHidden = true
            break
        default:
            break
        }
    }
    
    
}
