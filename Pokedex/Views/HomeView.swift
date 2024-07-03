//
//  HomeView.swift
//  Pokedex
//
//  Created by Sahil Ak on 01/07/2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm: HomeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let pokemons = vm.searchedPokemons {
                    List(pokemons) { pokemon in
                        NavigationLink(value: pokemon) {
                            pokemonRow(for: pokemon)
                        }
                    }
                    .listStyle(.plain)
                } else {
                    ProgressView()
                        .padding()
                }
            }
            .navigationTitle("Pokedex")
            .navigationDestination(for: PokemonLink.self) { pokemonLink in
                PokemonDetailView(vm: PokemonDetailViewModel(pokemonLink: pokemonLink))
            }
        }
        .searchable(text: $vm.searchText, isPresented: $vm.isSearching, prompt: "Search Pokemons")
        .task {
            await vm.loadPokemons()
        }
    }
    
    private func pokemonRow(for pokemon: PokemonLink) -> some View {
        HStack {
            PokemonImageView(url: pokemon.imageURL)
                .frame(width: 100, height: 100, alignment: .center)
            
            Text(pokemon.name.capitalized)
                .font(.title3)
        }
        .task {
            guard !vm.isSearching else { return }
            
            if let lastPokemon = vm.pokemons?.last {
                if pokemon.id == lastPokemon.id {
                    await vm.loadNextPageofPokemons()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
