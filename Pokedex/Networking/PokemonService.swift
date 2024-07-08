//
//  PokemonService.swift
//  Pokedex
//
//  Created by Sahil Ak on 02/07/2024.
//

import Foundation

/// Service cass for API calls to the Poke API
enum PokemonService {
    /// The base url for the Poke API
    private static let baseURL: URL? = URL(string: PokeAPI.baseURL)
    
    /// URL Session object with a custom configuration
    private static let session: URLSession = {
        let config = URLSessionConfiguration.default
        
        config.waitsForConnectivity = true
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 30
        
        return URLSession(configuration: config)
    }()
    
    /// Fetches Pokemons from the paginated PokeAPI.
    /// - Parameter url: The optional url to fetch the pokemons from, in terms of pagination. If no url is provided, the first page is fetched.
    /// - Returns: The API response including the pokemons list and the url for the next page of pokemons.
    public static func fetchPokemons(url: URL? = baseURL) async throws -> PokeAPIResponse {
        guard let url = url else { throw PokemonServiceError.invalidURL }
        
        let (data, _) = try await session.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let decodedData = try decoder.decode(PokeAPIResponse.self, from: data)
        
        return decodedData
    }
    
    /// Fetch detailed information about a specific pokemon using Poke API
    /// - Parameter id: The ID of the pokemon you want to fetch
    /// - Returns: All information about the pokemon including name, height, weight, stats etc.
    public static func fetchPokemonInformation(for id: Int) async throws -> PokemonInformation {
        guard let baseURL else { throw PokemonServiceError.invalidURL }
        
        let pokemonURL = baseURL.appending(path: "\(id)")
        
        let (data, _) = try await session.data(from: pokemonURL)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let info = try decoder.decode(PokemonInformation.self, from: data)
        
        return info
    }
}
