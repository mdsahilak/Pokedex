//
//  PokemonInformation.swift
//  Pokedex
//
//  Created by Sahil Ak on 03/07/2024.
//

import Foundation

struct PokemonInformation: Codable, Identifiable {
    var id: Int
    var name: String
    
    var statInfos: [StatInfo]
    
    var imageURL: URL? {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case statInfos = "stats"
    }
    
    struct StatInfo: Codable {
        var baseStat: Int
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
