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
    
    init(pokemonLink: PokemonLink) {
        self.pokemonLink = pokemonLink
    }
}
