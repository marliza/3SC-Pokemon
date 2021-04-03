//
//  StatsViewController.swift
//  Pokemon
//
//  Created by Marliza Viegas on 03/04/2021.
//

import UIKit

class StatsViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dataCardView: UIView!
    @IBOutlet weak var baseStatsView: UIView!
    
    @IBOutlet weak var heightValueLabel: UILabel!
    @IBOutlet weak var weightValueLabel: UILabel!
    @IBOutlet weak var typeValueLabel: UILabel!
    @IBOutlet weak var speciesValueLabel: UILabel!
    
    var pokemonStatData: PokemonStats? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set rounded corner for imageview
        imageView.layer.cornerRadius = 15.0
        imageView.layer.masksToBounds = true
        
        // set rounded corner for data imageview
        dataCardView.layer.cornerRadius = 15.0
        dataCardView.layer.masksToBounds = true

       setStatsData()

    }
    
    @IBAction func closeDetailView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setStatsData(){
        if let stat = pokemonStatData{
            // fetch the sprite for the pokemon and set imageView
            self.downloadPokemonImage(with: stat.sprites.mainImage.image) { (image) -> (Void) in
                self.imageView.image = image
            }
            
            heightValueLabel.text = String(Double(stat.height) / 10) + " m" // convert decimeter to meters
            weightValueLabel.text = String(Double(stat.weight) / 10) + " Kg" // convert hectograms to Kilograms
            
            // create comma separated string for types
            var typeList = [String]()
            for type in stat.types.enumerated(){
                typeList.append(type.element.type.name)
            }
            let joinedTyped = typeList.joined(separator: ", ")
            
            typeValueLabel.text = joinedTyped
            
            speciesValueLabel.text = String(stat.species.name)
            
        }
    }
    
}

//MARK: - PokeAPIService
extension StatsViewController{
    func downloadPokemonImage(with url: String, completion: @escaping (UIImage?) -> (Void)){
        PokeAPIService.shared.downloadImage(url: url, completion: completion)
    }
}
