//
//  ViewController.swift
//  Pokemon
//
//  Created by Marliza Viegas on 02/04/2021.
//

import UIKit

class HomeViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
