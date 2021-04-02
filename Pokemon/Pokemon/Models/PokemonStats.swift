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
    
    enum CodingKeys: String, CodingKey {
            case frontImage = "front_default"
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
