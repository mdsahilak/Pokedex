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
    
    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    func testInitialPokemonsIsNil() {
        XCTAssertNil(viewModel.pokemons, "Pokemons should be nil.")
    }
    
    func testInitialSelectedPokemonIsNil() {
        XCTAssertNil(viewModel.selectedPokemon, "Selected pokemon should be nil.")
    }
    
    func testInitialSearchStateIsNotSearching() {
        XCTAssertFalse(viewModel.isSearching, "IsSearching should be false.")
    }
    
    func testInitialSearchTextIsEmpty() {
        XCTAssertTrue(viewModel.searchText.isEmpty, "SearchText should be an empty string.")
    }
    
    func testFetchingPokemonsFromAPI() async throws {
        await viewModel.loadPokemons()
        
        let pokemonsCount = try XCTUnwrap(viewModel.pokemons).count
        let expectedCount = Constants.paginationLimit
        
        XCTAssertEqual(pokemonsCount, expectedCount, "API call should fetch the correct no. of pokemons.")
    }
    
    func testPaginationOfPokemonFetchesFromAPI() async throws {
        await viewModel.loadPokemons()
        await viewModel.loadNextPageofPokemons()
        
        let pokemonsCount = try XCTUnwrap(viewModel.pokemons).count
        let expectedCount = Constants.paginationLimit * 2
        
        XCTAssertEqual(pokemonsCount, expectedCount, "Pagination call should fetch the next page of pokemons.")
    }
    
    func testSearchingForPokemon() async throws {
        await viewModel.loadPokemons()
        
        let searchName = "charizard"
        viewModel.searchText = searchName
        
        let searchResults = try XCTUnwrap(viewModel.searchedPokemons)
        
        XCTAssertEqual(searchResults.count, 1)
        
        let result = try XCTUnwrap(searchResults.first)
        
        XCTAssertEqual(result.name, searchName, "Search should filter out the correct pokemon.")
    }
}
