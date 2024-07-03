//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by Sahil Ak on 02/07/2024.
//

import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var pokemons: [PokemonLink]? = nil
    
    @Published var showPaginationLoader: Bool = false
    @Published var nextPagePath: String? = nil
    
    public func loadPokemons() async {
        do {
            let data = try await PokemonService.fetchPokemons()
            
            pokemons = data.results
            nextPagePath = data.next
        } catch {
            print(error)
        }
    }
    
    public func loadNextPageofPokemons() async {
        do {
            guard let nextPage = nextPagePath else { return }
            
            withAnimation { showPaginationLoader = true }
            
            let data = try await PokemonService.fetchPokemons(url: URL(string: nextPage))
            
            pokemons?.append(contentsOf: data.results)
            nextPagePath = data.next
            
            withAnimation { showPaginationLoader = false }
        } catch {
            print(error)
        }
    }
}
