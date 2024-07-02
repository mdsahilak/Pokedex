//
//  HomeView.swift
//  Pokedex
//
//  Created by Sahil Ak on 01/07/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Hello, world!")
        }
        .padding()
        .task {
            do {
                let pokemons = try await PokemonService.fetchPokemons()
                print(pokemons)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    HomeView()
}