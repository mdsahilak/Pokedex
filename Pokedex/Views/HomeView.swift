//
//  HomeView.swift
//  Pokedex
//
//  Created by Sahil Ak on 01/07/2024.
//

import SwiftUI

/// View for the initial home screen
struct HomeView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @StateObject var vm: HomeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if let pokemons = vm.searchedPokemons {
                        pokemonCardGrid(for: pokemons)
                            .padding()
                        
                        if vm.showPaginationLoader {
                            CircularLoaderView()
                                .padding()
                        }
                    } else {
                        CircularLoaderView()
                            .padding()
                    }
                }
            }
            .refreshable {
                await vm.loadPokemons()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(TextAssets.appTitle)
            .sheet(item: $vm.selectedPokemon) { selectedPokemon in
                PokemonDetailView(vm: .init(pokemonLink: selectedPokemon))
            }
        }
        .searchable(text: $vm.searchText, isPresented: $vm.isSearching, placement: .navigationBarDrawer, prompt: TextAssets.searchBarPrompt)
        .task {
            await vm.loadPokemons()
        }
    }
    
    /// The grid of pokemon cards that adapt to multiple colums based on the device
    private func pokemonCardGrid(for pokemons: [PokemonLink]) -> some View {
        LazyVGrid(columns: columnsForDevice) {
            ForEach(pokemons) { pokemon in
                Button {
                    vm.selectedPokemon = pokemon
                } label: {
                    pokemonCard(for: pokemon)
                }
                .tint(.primary)
                .padding(7)
            }
        }
        .animation(.easeInOut, value: vm.searchedPokemons)
    }
    
    /// View representing an individual pokemon card
    private func pokemonCard(for pokemon: PokemonLink) -> some View {
        HStack {
            Spacer()
            
            VStack {
                PokemonImageView(url: pokemon.imageURL)
                    .frame(width: 100, height: 100, alignment: .center)
                    .accessibilityHidden(true)
                
                Text(pokemon.name.capitalized)
                    .font(.title3)
            }
            
            Spacer()
        }
        .padding()
        .cardBackground()
        .task {
            // Pagination fetch on load of last items
            guard !vm.isSearching else { return }
            
            if let lastPokemon = vm.pokemons?.last {
                if pokemon.id == lastPokemon.id {
                    await vm.loadNextPageofPokemons()
                }
            }
        }
    }
    
    /// Adaptive columns based on the horizontal size class of the device
    private var columnsForDevice: [GridItem] {
        if horizontalSizeClass == .regular {
            return [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        } else {
            return [GridItem(.flexible())]
        }
    }
}

#Preview {
    HomeView()
}
