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
    
    var pokemonStatData: PokemonStats? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set rounded corner for imageview
        imageView.layer.cornerRadius = 15.0
        imageView.layer.masksToBounds = true
        
        // set rounded corner for data imageview
        dataCardView.layer.cornerRadius = 15.0
        dataCardView.layer.masksToBounds = true

        if let stat = pokemonStatData{
            // fetch the sprite for the pokemon and set imageView
            self.downloadPokemonImage(with: stat.sprites.mainImage.image) { (image) -> (Void) in
                self.imageView.image = image
            }
        }

    }
    
    @IBAction func closeDetailView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

//MARK: - PokeAPIService
extension StatsViewController{
    func downloadPokemonImage(with url: String, completion: @escaping (UIImage?) -> (Void)){
        PokeAPIService.shared.downloadImage(url: url, completion: completion)
    }
}
