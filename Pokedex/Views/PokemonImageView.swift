//
//  PokemonImageView.swift
//  Pokedex
//
//  Created by Sahil Ak on 02/07/2024.
//

import SwiftUI
import NukeUI

struct PokemonImageView: View {
    var url: URL? = nil
    var contentMode: ContentMode = .fit
    
    var body: some View {
        LazyImage(url: url) { state in
            if let image = state.image {
                image
                    .resizable()
                    .aspectRatio(1, contentMode: contentMode)
            } else if state.error != nil {
                Image(systemName: "exclamationmark.circle")
                    .aspectRatio(1, contentMode: .fit)
            } else {
                ProgressView()
                    .frame(width: 33, height: 33)
                    .padding()
            }
        }
    }
}

#Preview {
    PokemonImageView()
}