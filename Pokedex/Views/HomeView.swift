//
//  HomeView.swift
//  Pokedex
//
//  Created by Sahil Ak on 01/07/2024.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @StateObject var vm: HomeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let pokemons = vm.searchedPokemons {
                    ScrollView {
                        LazyVGrid(columns: columnsForDevice()) {
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
                        .padding()
                        
                        if vm.showPaginationLoader {
                            CircularLoaderView()
                                .padding()
                        }
                    }
                } else {
                    CircularLoaderView()
                        .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Pokedex")
            .sheet(item: $vm.selectedPokemon) { selectedPokemon in
                PokemonDetailView(vm: .init(pokemonLink: selectedPokemon))
            }
        }
        .searchable(text: $vm.searchText, isPresented: $vm.isSearching, placement: .navigationBarDrawer, prompt: "Search Pokemons")
        .task {
            await vm.loadPokemons()
        }
    }
    
    private func pokemonCard(for pokemon: PokemonLink) -> some View {
        HStack {
            Spacer()
            
            VStack {
                PokemonImageView(url: pokemon.imageURL)
                    .frame(width: 100, height: 100, alignment: .center)
                
                Text(pokemon.name.capitalized)
                    .font(.title3)
            }
            
            Spacer()
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 13)
                .foregroundStyle(.gray.gradient.opacity(0.3))
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
    
    private func columnsForDevice() -> [GridItem] {
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
