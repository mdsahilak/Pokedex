//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Sahil Ak on 03/07/2024.
//

import SwiftUI

struct PokemonDetailView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: PokemonDetailViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack {
                    if let pokemon = vm.pokemonInfo {
                        indicatorView
                        
                        imageCarousel(for: pokemon)
                        
                        heightAndWeightBar(for: pokemon)
                        
                        statsView(for: pokemon)
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
                    dismissButton
                }
            }
        }
    }
    
    private func imageCarousel(for pokemon: PokemonInformation) -> some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                pokemonImageCard(for: pokemon.officialSpriteURL)
                    .id(0)
                
                pokemonImageCard(for: pokemon.shinySpriteURL)
                    .id(1)
                
                pokemonImageCard(for: pokemon.homeSpriteURL)
                    .id(2)
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: $vm.currentImageIndex)
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.paging)
    }
    
    @ViewBuilder
    private func heightAndWeightBar(for pokemon: PokemonInformation) -> some View {
        Divider()
        HStack {
            Text("Height: \(pokemon.height)")
            Divider()
            Text("Weight: \(pokemon.weight)")
        }
        Divider()
    }
    
    @ViewBuilder
    private func statsView(for pokemon: PokemonInformation) -> some View {
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
    }
    
    private func pokemonImageCard(for url: URL?) -> some View {
        PokemonImageView(url: url)
            .frame(maxHeight: 350)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 13)
                    .foregroundStyle(.gray.gradient.opacity(0.3))
            }
            .padding(7)
            .containerRelativeFrame(.horizontal)
            .scrollTransition(.animated, axis: .horizontal) { content, phase in
                content
                    .opacity(phase.isIdentity ? 1.0 : 0.7)
                    .scaleEffect(phase.isIdentity ? 1.0 : 0.7)
            }
    }
    
    private var indicatorView: some View {
        HStack {
            ForEach(0..<3, id: \.self) { val in
                let current = vm.currentImageIndex ?? 0
                
                Button(action: {
                    withAnimation {
                        vm.currentImageIndex = val
                    }
                }, label: {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 8))
                        .foregroundStyle(current == val ? Color(.darkGray) : Color(.lightGray))
                })
            }
        }
        .padding(.bottom, 7)
    }
    
    private var dismissButton: some View {
        Button {
            dismiss()
        } label: {
            Label("Dismiss", systemImage: "chevron.down")
        }
    }
}

#Preview {
    PokemonDetailView(vm: .init(pokemonLink: .mock))
}
