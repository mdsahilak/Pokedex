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
                    
                    Text("Height: \(pokemon.height)")
                    Text("Weight: \(pokemon.weight)")
                    
                    ForEach(pokemon.statInfos) { statInfo in
                        ProgressView(value: statInfo.baseStat, total: 255.0) {
                            Text(statInfo.statLink.name)
                        } currentValueLabel: {
                            HStack {
                                Text("\(statInfo.baseStat, specifier: "%.0f")")
                                Spacer()
                                Text("255")
                            }
                        }
                        
                    }
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
        .scrollIndicators(.hidden)
    }
}

#Preview {
    PokemonDetailView(vm: .mock)
}
