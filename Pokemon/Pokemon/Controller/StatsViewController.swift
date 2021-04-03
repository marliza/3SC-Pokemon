//
//  StatsViewController.swift
//  Pokemon
//
//  Created by Marliza Viegas on 03/04/2021.
//

import UIKit

class StatsViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var pokemonStatData: PokemonStats? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        if let stat = pokemonStatData{
            // fetch the sprite for the pokemon and set imageView
            self.downloadPokemonImage(with: stat.sprites.mainImage.image) { (image) -> (Void) in
                self.imageView.image = image
            }
        }

    }
    
}

//MARK: - PokeAPIService
extension StatsViewController{
    func downloadPokemonImage(with url: String, completion: @escaping (UIImage?) -> (Void)){
        PokeAPIService.shared.downloadImage(url: url, completion: completion)
    }
}
