//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Sahil Ak on 03/07/2024.
//

import SwiftUI

struct PokemonDetailView: View {
    @ObservedObject var vm: PokemonDetailViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                if let pokemon = vm.pokemonInfo {
                    PokemonImageView(url: pokemon.imageURL)
                        .frame(maxHeight: 350)
                        .padding()
                    
                    Text(pokemon.name)
                        .font(.title)
                } else {
                    SpacingLoaderView()
                        .padding(.top, 190)
                }
            }
            .padding()
            .task {
                await vm.loadPokemonInformation()
            }
        }
    }
}

#Preview {
    PokemonDetailView(vm: .mock)
}
