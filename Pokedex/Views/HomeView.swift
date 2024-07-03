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
        NavigationSplitView {
            VStack {
                if let pokemons = vm.pokemons {
                    List(pokemons, selection: $vm.selectedPokemon) { pokemon in
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
        } detail: {
            if let selectedPokemon = vm.selectedPokemon {
                PokemonDetailView(vm: PokemonDetailViewModel(pokemonLink: selectedPokemon))
                    .id(vm.selectedPokemon)
            } else {
                Text("Please select a pokemon.")
            }
        }
        .task {
            await vm.loadPokemons()
        }
    }
    
    private func pokemonRow(for pokemon: PokemonLink) -> some View {
        Section {
            HStack {
                PokemonImageView(url: pokemon.imageURL)
                    .frame(width: 100, height: 100, alignment: .center)
                
                Text(pokemon.name)
            }
        }
    }
}

#Preview {
    HomeView()
}
