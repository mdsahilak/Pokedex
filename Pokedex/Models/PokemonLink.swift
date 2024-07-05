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

struct PokemonLink: Codable, Hashable, Identifiable {
    static let mock: PokemonLink = .init(name: "squirtle", url: "https://pokeapi.co/api/v2/pokemon/7/")
    
    var id: Int { Int((url as NSString).lastPathComponent) ?? 0 }
    
    var name: String
    var url: String
    
    var imageURL: URL? {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")
    }
}
