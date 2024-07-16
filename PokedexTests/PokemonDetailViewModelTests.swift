//
//  PokemonDetailViewModelTests.swift
//  PokedexTests
//
//  Created by Sahil Ak on 16/07/2024.
//

import XCTest
@testable import Pokedex

@MainActor
final class PokemonDetailViewModelTests: XCTestCase {
    private var viewModel: PokemonDetailViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = PokemonDetailViewModel(pokemonLink: .mock)
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    
}
