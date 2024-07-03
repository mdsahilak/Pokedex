//
//  PokemonService.swift
//  Pokedex
//
//  Created by Sahil Ak on 02/07/2024.
//

import Foundation

final class PokemonService {
    private init() {  }
    
    private static let baseURL: URL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    public static func fetchPokemons() async throws -> [PokemonLink] {
        let (data, _) = try await URLSession.shared.data(from: baseURL)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let decodedData = try decoder.decode(PokemonAPIResponse.self, from: data)
        
        return decodedData.results
    }
    
    public static func fetchPokemonInformation(for url: String) async throws -> PokemonInformation {
        let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let info = try decoder.decode(PokemonInformation.self, from: data)
        
        return info
    }
}
