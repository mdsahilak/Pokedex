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
                if let pokemons = vm.pokemons {
                    List {
                        ForEach(pokemons) { pokemon in
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
        }
        .task {
            await vm.loadPokemons()
            await vm.loadPokemonInformation(for: "https://pokeapi.co/api/v2/pokemon/7")
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
