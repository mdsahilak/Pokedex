//
//  PokemonLink.swift
//  Pokedex
//
//  Created by Sahil Ak on 02/07/2024.
//

import Foundation

struct PokemonLink: Codable, Hashable, Identifiable {
    static let mock: PokemonLink = .init(name: "squirtle", url: "\(PokeAPI.baseURL)/7/")
    
    var id: Int { Int((url as NSString).lastPathComponent) ?? 0 }
    
    var name: String
    var url: String
    
    var imageURL: URL? { URL(string: PokeAPI.officialSpriteURL(for: id)) }
}
