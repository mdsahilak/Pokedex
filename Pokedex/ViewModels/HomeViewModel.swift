//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by Sahil Ak on 02/07/2024.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var pokemons: [PokemonLink]? = nil
    
    public func loadPokemons() async {
        do {
            pokemons = try await PokemonService.fetchPokemons()
        } catch {
            print(error)
        }
    }
}
