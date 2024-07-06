//
//  PokeAPI.swift
//  Pokedex
//
//  Created by Sahil Ak on 05/07/2024.
//

import Foundation

enum PokeAPI {
    static let baseURL: String = "https://pokeapi.co/api/v2/pokemon/"
    
    private static let baseAssetURL: String = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other"
    
    static func officialSpriteURL(for id: Int) -> String {
        return "\(baseAssetURL)/official-artwork/\(id).png"
    }
    
    static func shinySpriteURL(for id: Int) -> String {
        return "\(baseAssetURL)/official-artwork/shiny/\(id).png"
    }
    
    static func homeSpriteURL(for id: Int) -> String {
        return "\(baseAssetURL)/home/\(id).png"
    }
}
