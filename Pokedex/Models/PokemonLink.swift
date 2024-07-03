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

struct PokemonLink: Codable, Identifiable {
    var id: String { name }
    
    var name: String
    var url: String
    
    var imageURL: URL? {
        let id = (url as NSString).lastPathComponent
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")
    }
}
