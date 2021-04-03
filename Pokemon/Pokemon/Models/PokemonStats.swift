//
//  PokemonStats.swift
//  Pokemon
//
//  Created by Marliza Viegas on 02/04/2021.
//

import Foundation

struct PokemonStats: Decodable {
    let id: Int
    let name: String
    let sprites: Sprites
    let stats:[Statistics]
}

struct Sprites: Decodable{
    let frontImage: String
    var mainImage: Artwork

    enum CodingKeys: String, CodingKey {
        case other = "other"
        case frontImage = "front_default"
        case mainImage = "official-artwork"
    }
    
    init(from decoder: Decoder) throws{

        let container = try decoder.container(keyedBy: CodingKeys.self)
        frontImage = try container.decode(String.self, forKey: .frontImage)

        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .other)
        mainImage = try Artwork(from: data.superDecoder(forKey: .mainImage))
    }

}

struct Artwork: Decodable{
    let image: String
    
    private enum CodingKeys: String, CodingKey{
        case image = "front_default"
    }
}


struct Statistics: Decodable {
    let baseStat: Int
    let effort: Int
    let stat: Stat
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
}

struct Stat:Decodable {
    let name: String
    let url: String
}
