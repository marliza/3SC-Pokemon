//
//  ViewController.swift
//  Pokemon
//
//  Created by Marliza Viegas on 02/04/2021.
//

import UIKit

class HomeViewController: UICollectionViewController {
    
    var pokemonStatsArray: [PokemonStats]?{
        didSet{
            self.collectionPokemonList = pokemonStatsArray
        }
    }
    var pokemonImage: UIImage?
    
    var collectionPokemonList: [PokemonStats]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = K.navTitle
        
        fetchPokemonList()
    }
    
    //MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! StatsViewController
        if let indexPath = collectionView.indexPathsForSelectedItems?.first{
            destinationVC.pokemonStatData = collectionPokemonList?[indexPath.item]
        }

    }

    
}
//MARK: - UICollectionViewDataSource

extension HomeViewController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionPokemonList?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.pokemonCellIdentifier, for: indexPath) as! PokemonCollectionCell
        if let poke = collectionPokemonList?[indexPath.item]{
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
        performSegue(withIdentifier: K.statsViewSegue, sender: self)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: K.collectionViewHeader, for: indexPath)
            
        return searchView
    }
    
    //MARK: - Scroll
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }

}

//MARK: - SearchBarDelegate
extension HomeViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text?.lowercased(), searchBar.text != ""{
            if let filteredArray = self.pokemonStatsArray?.filter({$0.name.contains(searchText)}){
                self.collectionPokemonList = filteredArray
                self.collectionView.reloadData()
            }

        }
    }
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0{
            self.collectionPokemonList = self.pokemonStatsArray
            self.collectionView.reloadData()

        }
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
    
    // search pokemon with name or id
    func searchPokemon(with parameter: String){
        PokeAPIService.shared.requestFetchPokemon(with: parameter) { (pokeStats, error) in
            if let error = error{
                print("error: \(error.localizedDescription)")
                return
            }
            
            if let poke = pokeStats{
                var newPokeList = [PokemonStats]()
                newPokeList.append(poke)
                
                self.pokemonStatsArray = newPokeList
                self.collectionView.reloadData()
            }
        }
    }
    
    func download(imageURl url: String, completion:  @escaping (UIImage?) -> (Void)){
        PokeAPIService.shared.downloadImage(url: url, completion: completion)
    }
}



