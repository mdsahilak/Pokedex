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
    
    func testInitialPokemonInfoIsNil() {
        XCTAssertNil(viewModel.pokemonInfo, "PokemonInfo should be nil.")
    }
    
    func testInitialCurrentImageIndexIsNil() {
        XCTAssertNil(viewModel.currentImageIndex, "Current Image Index should be nil.")
    }
    
    func testFetchingPokemonInformationFromAPI() async throws {
        await viewModel.loadPokemonInformation()
        
        let pokemonInfo = try XCTUnwrap(viewModel.pokemonInfo, "Pokemon Info should not be nil.")
        
        XCTAssertEqual(pokemonInfo.id, viewModel.pokemonLink.id, "Pokemon Link and fetched Pokemon Info should be the same pokemon having the same ID.")
    }
}
