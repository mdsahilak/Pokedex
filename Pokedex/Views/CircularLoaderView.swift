//
//  CircularLoaderView.swift
//  Pokedex
//
//  Created by Sahil Ak on 03/07/2024.
//

import SwiftUI

struct CircularLoaderView: View {
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                ProgressView()
                    .padding(7.7)
                    .background(
                        Circle()
                            .foregroundColor(.gray)
                            .opacity(0.1)
                    )
                    .padding()
                
                Spacer()
            }
            
            Spacer()
        }
    }
}

#Preview {
    CircularLoaderView()
}
