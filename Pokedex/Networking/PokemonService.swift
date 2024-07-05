//
//  PokemonService.swift
//  Pokedex
//
//  Created by Sahil Ak on 02/07/2024.
//

import Foundation

final class PokemonService {
    private init() {  }
    
    private static let baseURL: URL? = URL(string: "https://pokeapi.co/api/v2/pokemon/")
    
    private static let session: URLSession = {
        let config = URLSessionConfiguration.default
        
        config.waitsForConnectivity = true
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 30
        
        return URLSession(configuration: config)
    }()
    
    public static func fetchPokemons(url: URL? = baseURL) async throws -> PokeAPIResponse {
        guard let url = url else { throw PokemonServiceError.invalidURL }
        
        let (data, _) = try await session.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let decodedData = try decoder.decode(PokeAPIResponse.self, from: data)
        
        return decodedData
    }
    
    public static func fetchPokemonInformation(for url: URL?) async throws -> PokemonInformation {
        guard let url = url else { throw PokemonServiceError.invalidURL }
        
        let (data, _) = try await session.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let info = try decoder.decode(PokemonInformation.self, from: data)
        
        return info
    }
}
