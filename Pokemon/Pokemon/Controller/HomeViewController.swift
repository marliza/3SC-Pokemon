//
//  ViewController.swift
//  Pokemon
//
//  Created by Marliza Viegas on 02/04/2021.
//

import UIKit

class HomeViewController: UICollectionViewController {
    
    var pokemonStatsArray: [PokemonStats]?
    var pokemonImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pokemon"
        fetchPokemonList()
    }
    
    //MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! StatsViewController
        if let indexPath = collectionView.indexPathsForSelectedItems?.first{
            destinationVC.pokemonStatData = pokemonStatsArray?[indexPath.item]
        }

    }

    
}
//MARK: - UICollectionViewDataSource

extension HomeViewController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pokemonStatsArray?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as! PokemonCollectionCell
        if let poke = pokemonStatsArray?[indexPath.item]{
            cell.name = poke.name
            
            // fetch the sprite for the pokemon and set imageView
            self.download(imageURl: poke.sprites.frontImage) { (image) -> (Void) in
                cell.image = image
            }
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension HomeViewController{
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PokemonCollectionCell

        pokemonImage = cell.image
        performSegue(withIdentifier: "StatsViewSegue", sender: self)
    }
}

//MARK: - PokeAPIService 

extension HomeViewController{
    func fetchPokemonList() {
        // fetch list of pokemon (results array)
        PokeAPIService.shared.requestFetchPokemonList { (pokeStats, error) in
            if let error = error{
                print("error: \(error.localizedDescription)")
                return
            }
          
            if let pokeStats = pokeStats{
                self.pokemonStatsArray = pokeStats
                self.collectionView.reloadData()
            }
        }
    }
    
    func download(imageURl url: String, completion:  @escaping (UIImage?) -> (Void)){
        PokeAPIService.shared.downloadImage(url: url, completion: completion)
    }
}



