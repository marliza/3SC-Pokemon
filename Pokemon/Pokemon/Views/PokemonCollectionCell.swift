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
            
            // set rounded corner for imageview
            imageView.layer.cornerRadius = 15.0
            imageView.layer.masksToBounds = true

        }
    }
    
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    override func layoutSubviews() {
            // set rounded corner for cell section
            self.layer.cornerRadius = 15.0
            self.layer.masksToBounds = true
            
        }
    
}
