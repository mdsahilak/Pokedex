//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Sahil Ak on 03/07/2024.
//

import SwiftUI

struct PokemonDetailView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: PokemonDetailViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack {
                    if let pokemon = vm.pokemonInfo {
                        PokemonImageView(url: pokemon.officialSpriteURL)
                            .padding()
                            .frame(maxHeight: 350)
                            .background {
                                RoundedRectangle(cornerRadius: 13)
                                    .foregroundStyle(.gray.gradient.opacity(0.3))
                            }
                        
                        Divider()
                        Text("Height: \(pokemon.height) | Weight: \(pokemon.weight)")
                        Divider()
                        
                        ForEach(pokemon.statInfos) { statInfo in
                            ProgressView(value: statInfo.baseStat, total: 255.0) {
                                HStack {
                                    Text(statInfo.statLink.name.capitalized)
                                    Spacer()
                                    Text("\(statInfo.baseStat, specifier: "%.0f")")
                                }
                            }
                            .padding(7)
                        }
                    } else {
                        CircularLoaderView()
                            .padding(.top, 190)
                    }
                }
                .padding()
                .task {
                    await vm.loadPokemonInformation()
                }
            }
            .scrollIndicators(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("\(vm.pokemonLink.name.capitalized)")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Dismiss", systemImage: "chevron.down")
                    }

                }
            }
        }
    }
}

#Preview {
    PokemonDetailView(vm: .mock)
}
