//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Sahil Ak on 03/07/2024.
//

import SwiftUI

/// View to display detailed information about a pokemon
struct PokemonDetailView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: PokemonDetailViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack {
                    if let pokemon = vm.pokemonInfo {
                        indicatorView
                            .accessibilityHidden(true)
                        
                        imageCarousel(for: pokemon)
                            .accessibilityHidden(true)
                        
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
    
    /// Image carousel with special zoom effects
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
    
    /// Height and weight display bar
    @ViewBuilder
    private func heightAndWeightBar(for pokemon: PokemonInformation) -> some View {
        Divider()
        HStack {
            Text("\(TextAsset.heightText): \(pokemon.height)")
            Divider()
            Text("\(TextAsset.weightText): \(pokemon.weight)")
        }
        Divider()
    }
    
    /// View to display the statics using progress bars
    @ViewBuilder
    private func statsView(for pokemon: PokemonInformation) -> some View {
        ForEach(pokemon.statInfos) { statInfo in
            ProgressView(value: statInfo.baseStat, total: Constants.statsMaxValue) {
                HStack {
                    Text(statInfo.statLink.name.capitalized)
                    Spacer()
                    Text("\(statInfo.baseStat, specifier: "%.0f")")
                }
            }
            .padding(7)
        }
    }
    
    /// Card to display a single sprite of the pokemon
    private func pokemonImageCard(for url: URL?) -> some View {
        PokemonImageView(url: url)
            .frame(maxHeight: 350)
            .padding()
            .cardBackground()
            .padding(7)
            .containerRelativeFrame(.horizontal)
            .scrollTransition(.animated, axis: .horizontal) { content, phase in
                content
                    .opacity(phase.isIdentity ? 1.0 : 0.7)
                    .scaleEffect(phase.isIdentity ? 1.0 : 0.7)
            }
    }
    
    /// Interactive Indicator for the image carousel
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
    
    /// Dismiss button for the sheet's navigation bar
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
