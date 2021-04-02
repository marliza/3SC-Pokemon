//
//  ViewController.swift
//  Pokemon
//
//  Created by Marliza Viegas on 02/04/2021.
//

import UIKit
import Alamofire

class HomeViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPokemonList()
    }
    
    
}
//MARK: - UICollectionViewDataSource

extension HomeViewController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as! PokemonCollectionCell
        cell.name = "Pickachu"
        
        return cell
    }
}

//MARK: -

extension HomeViewController{
    func fetchPokemonList(){
        // 1
        let request = AF.request("https://pokeapi.co/api/v2/pokemon")
        // 2
        request.responseJSON { (data) in
            print(data)
        }
    }
}
