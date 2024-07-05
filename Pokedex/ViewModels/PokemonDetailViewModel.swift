//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Sahil Ak on 03/07/2024.
//

import SwiftUI

@MainActor
final class PokemonDetailViewModel: ObservableObject {
    static let mock: PokemonDetailViewModel = .init(pokemonLink: .mock)
    
    let pokemonLink: PokemonLink
    
    @Published var pokemonInfo: PokemonInformation? = nil
    @Published var currentImageIndex: Int? = nil
    
    init(pokemonLink: PokemonLink) {
        self.pokemonLink = pokemonLink
    }
    
    public func loadPokemonInformation() async {
        do {
            pokemonInfo = try await PokemonService.fetchPokemonInformation(for: URL(string: pokemonLink.url))
        } catch {
            print(error)
        }
    }
}
