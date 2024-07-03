//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Sahil Ak on 03/07/2024.
//

import Foundation

@MainActor
final class PokemonDetailViewModel: ObservableObject {
    static let mock: PokemonDetailViewModel = .init(pokemonLink: .mock)
    
    let pokemonLink: PokemonLink
    
    @Published var pokemonInfo: PokemonInformation? = nil
    
    init(pokemonLink: PokemonLink) {
        self.pokemonLink = pokemonLink
    }
    
    public func loadPokemonInformation() async {
        do {
            pokemonInfo = try await PokemonService.fetchPokemonInformation(for: pokemonLink.url)
        } catch {
            print(error)
        }
    }
}
