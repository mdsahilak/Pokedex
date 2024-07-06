//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Sahil Ak on 03/07/2024.
//

import SwiftUI

@MainActor
final class PokemonDetailViewModel: ObservableObject {
    let pokemonLink: PokemonLink
    
    /// The detailed information related to the currently selected pokemon
    @Published var pokemonInfo: PokemonInformation? = nil
    
    /// Value indicating the current image shown in the carousel
    @Published var currentImageIndex: Int? = nil
    
    init(pokemonLink: PokemonLink) {
        self.pokemonLink = pokemonLink
    }
    
}

// MARK: - API Call Handlers -
extension PokemonDetailViewModel {
    /// Fetch detailed information about the selected pokemon
    public func loadPokemonInformation() async {
        do {
            pokemonInfo = try await PokemonService.fetchPokemonInformation(for: pokemonLink.id)
        } catch {
            print(error)
        }
    }
}
