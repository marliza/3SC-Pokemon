//
//  ViewController.swift
//  Pokemon
//
//  Created by Marliza Viegas on 02/04/2021.
//

import UIKit
import Alamofire
import AlamofireImage

class HomeViewController: UICollectionViewController {
    
//    var pokemons: [PokemonData]?
    var pokemonStatsArray: [PokemonStats]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPokemonList()
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
            AF.request(poke.sprites.frontImage).responseImage { response in
                if case .success(let image) = response.result {
                    cell.image = image
                }
            }
        }
        return cell
    }
}

//MARK: -

extension HomeViewController{
    func fetchPokemonList() {
        // fetch list of pokemon (results array)
        PokeAPIService.shared.requestFetchPokemonList { (pokemon, error) in
            if let error = error{
                print("error: \(error.localizedDescription)")
                return
            }
            guard let pokemon = pokemon?.all else{
                return
            }
            // fetch the pokemon details using the url endpoint
            PokeAPIService.shared.fetchData(for: pokemon) { (pokeStats, error) in
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
    }
}
