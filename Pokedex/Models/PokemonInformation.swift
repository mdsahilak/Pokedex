//
//  PokemonInformation.swift
//  Pokedex
//
//  Created by Sahil Ak on 03/07/2024.
//

import Foundation

struct PokemonInformation: Codable, Identifiable {
    var height: Int
    
    var id: Int
    var name: String
    
    var statInfos: [StatInfo]
    
    var weight: Int
    
    var homeSpriteURL: URL? {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(id).png")
    }
    
    var officialSpriteURL: URL? {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")
    }
    
    var shinySpriteURL: URL? {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/\(id).png")
    }
    
    enum CodingKeys: String, CodingKey {
        case height
        case id
        case name
        case statInfos = "stats"
        case weight
    }
    
    struct StatInfo: Codable, Identifiable {
        var id: String { statLink.name }
        
        var baseStat: Double
        var statLink: StatLink
        
        enum CodingKeys: String, CodingKey {
            case baseStat
            case statLink = "stat"
        }
        
        struct StatLink: Codable {
            var name: String
            var url: String
        }
    }
    
}
