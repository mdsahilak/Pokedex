//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by Sahil Ak on 02/07/2024.
//

import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {
    /// List of all the fetched pokemons
    @Published var pokemons: [PokemonLink]? = nil
    
    /// The pokemon that was selected to be shown in the detail screen.
    @Published var selectedPokemon: PokemonLink? = nil
    
    // Search Bar
    @Published var isSearching: Bool = false
    @Published var searchText: String = ""
    
    /// State to show / hide the loader while fetching the next page of pokemons
    @Published var showPaginationLoader: Bool = false
    
    /// The url  to fetch the next page of pokemons
    private var nextPagePath: String? = nil
    
    /// Filtered list of pokemons using the keywords from the search bar.
    public var searchedPokemons: [PokemonLink]? {
        guard let pokemons else { return nil }
        
        if searchText.isEmpty {
            return pokemons
        } else {
            let filteredPokemons = pokemons.filter { $0.name.contains(searchText.lowercased()) }
            return filteredPokemons
        }
    }
    
}

// MARK: - API Call Handlers -
extension HomeViewModel {
    /// Initial API fetch for Pokemons for the first page of pokemons
    public func loadPokemons() async {
        do {
            let data = try await PokemonService.fetchPokemons()
            
            pokemons = data.results
            nextPagePath = data.next
        } catch {
            Dropper.send(.error, title: TextAssets.errorText, subtitle: TextAssets.failedToFetchPokemonsError)
            pokemons = []
            
            print(error)
        }
    }
    
    /// Fetches the next page of upto 20 pokemons
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
