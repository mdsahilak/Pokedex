//
//  PokemonLink.swift
//  Pokedex
//
//  Created by Sahil Ak on 02/07/2024.
//

import Foundation

struct PokemonAPIResponse: Codable {
    var count: Int
    var next: String?
    var previous: String?
    
    var results: [PokemonLink]
}

struct PokemonLink: Codable {
    var name: String
    var url: String
}
