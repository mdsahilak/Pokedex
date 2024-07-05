//
//  PokeAPIResponse.swift
//  Pokedex
//
//  Created by Sahil Ak on 05/07/2024.
//

import Foundation

struct PokeAPIResponse: Codable {
    var count: Int
    var next: String?
    var previous: String?
    
    var results: [PokemonLink]
}
