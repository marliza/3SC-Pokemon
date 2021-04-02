//
//  Pokemon.swift
//  Pokemon
//
//  Created by Marliza Viegas on 02/04/2021.
//

import Foundation

struct Pokemon: Decodable{
    let all: [PokemonData]
    
    enum CodingKeys: String, CodingKey {
            case all = "results"
    }
}

struct PokemonData: Decodable{
    let name: String
    let url: String
}


