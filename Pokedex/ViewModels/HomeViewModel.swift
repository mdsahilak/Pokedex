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
    @Published var selectedPokemon: PokemonLink? = nil
    
    public func loadPokemons() async {
        do {
            pokemons = try await PokemonService.fetchPokemons()
        } catch {
            print(error)
        }
    }
    
    public func loadPokemonInformation(for url: String) async {
        do {
            let info = try await PokemonService.fetchPokemonInformation(for: url)
            print(info)
        } catch {
            print(error)
        }
    }
}
