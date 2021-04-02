//
//  PokeAPIService.swift
//  Pokemon
//
//  Created by Marliza Viegas on 02/04/2021.
//

import Foundation
import Alamofire
import AlamofireImage

struct PokeAPIService {
    
    // MARK: - Singleton
    static let shared = PokeAPIService()
    
    // MARK: - URL
    private var baseURL = "https://pokeapi.co/api/v2/pokemon"
    
    // MARK: - Services
    func requestFetchPokemonList(completion: @escaping (Pokemon?, Error?) -> ()){
        AF.request(baseURL)
            .validate()
            .responseDecodable(of: Pokemon.self) { (response) in
                if let error = response.error {
                    completion(nil, error)
                    return
                }
                if let pokemon = response.value {
                    completion(pokemon, nil)
                    return
                }
            }
    }
    
    func fetchData(for list: [PokemonData], completion: @escaping([PokemonStats]?, Error?) -> ()) {
        var items: [PokemonStats] = []
        
        // use dispatchGroup to notifiy when all the asynchronous call have completed
        let fetchGroup = DispatchGroup()
        
        // for every pokemon url, get the detail json
        list.forEach { (pokemon) in
            let pokemonUrl = pokemon.url
            
            fetchGroup.enter()
            
            AF.request(pokemonUrl).validate().responseDecodable(of: PokemonStats.self) { (response) in
                if let error = response.error {
                    completion(nil, error)
                    return
                }
                if let value = response.value {
                    items.append(value)
                }
                
                fetchGroup.leave()
            }
        }
        // notify when the asynchronous calls are complete
        fetchGroup.notify(queue: .main) {
            completion(items, nil)
            return
        }
    }
    
    func downloadImage(url: String, completion: @escaping (Image?) -> (Void)){
        AF.request(url, method: .get).responseImage { (response) in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure:
                completion(nil)
            }
        }
        
        
    }
    
}
