//
//  PokemonCollectionCell.swift
//  Pokemon
//
//  Created by Marliza Viegas on 02/04/2021.
//

import UIKit

class PokemonCollectionCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
}
