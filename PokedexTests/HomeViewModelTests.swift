//
//  HomeViewModelTests.swift
//  PokedexTests
//
//  Created by Sahil Ak on 16/07/2024.
//

import XCTest
@testable import Pokedex

@MainActor
final class HomeViewModelTests: XCTestCase {
    private var viewModel: HomeViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = HomeViewModel()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        viewModel = nil
    }
    
    func testInitialPokemonsIsNil() {
        XCTAssertNil(viewModel.pokemons, "Pokemons is not nil")
    }
    
    func testInitialSelectedPokemonIsNil() {
        XCTAssertNil(viewModel.selectedPokemon, "Selected pokemon is not nil")
    }
    
    func testInitialSearchStateIsNotSearching() {
        XCTAssertFalse(viewModel.isSearching, "IsSearching is not false")
    }
    
    func testInitialSearchTextIsEmpty() {
        XCTAssertTrue(viewModel.searchText.isEmpty, "SearchText is not an empty string")
    }
    
    func testFetchingPokemonsFromAPI() async throws {
        await viewModel.loadPokemons()
        
        let pokemonsCount = try XCTUnwrap(viewModel.pokemons).count
        let expectedCount = Constants.paginationLimit
        
        XCTAssertEqual(pokemonsCount, expectedCount, "Failed to fetch pokemons from API")
    }
    
    func testPaginationOfPokemonFetchesFromAPI() async throws {
        await viewModel.loadPokemons()
        await viewModel.loadNextPageofPokemons()
        
        let pokemonsCount = try XCTUnwrap(viewModel.pokemons).count
        let expectedCount = Constants.paginationLimit * 2
        
        XCTAssertEqual(pokemonsCount, expectedCount, "Failed to fetch next page of pokemons")
    }
    
    func testSearchingForPokemon() async throws {
        await viewModel.loadPokemons()
        
        let searchName = "charizard"
        viewModel.searchText = searchName
        
        let searchResults = try XCTUnwrap(viewModel.searchedPokemons)
        
        XCTAssertEqual(searchResults.count, 1)
        
        let result = try XCTUnwrap(searchResults.first)
        
        XCTAssertEqual(result.name, searchName)
    }
}
