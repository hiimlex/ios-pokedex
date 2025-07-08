//
//  PokemonGridView.swift
//  pokedex
//
//  Created by Adaumi Alex Rodrigues Alves on 07/07/25.
//

import SwiftUI

struct PokemonGridView: View {
    @StateObject private var viewModel = PokemonCardModel()
    @State private var searchText = ""
    

    // Define 2 flexible columns
    let columns = Array(repeating: GridItem(.flexible(), spacing: 18, alignment: .center), count: 2)

    var body: some View {
        ScrollView (showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 18) {
                ForEach(viewModel.pokemons) { pokemon in
                    NavigationLink(value: pokemon){
                        PokemonCardView(pokemon: pokemon)
                    }
                }
            }
            
        }
        .padding(18)
        .task {
            await viewModel.fetchPokemons()
        }
        .navigationTitle("Pokédex")
        .searchable(text: $searchText, prompt: "Search for a pokemon...")
        .autocorrectionDisabled()
        .onChange(of: searchText) {
           Task {
             await onSearch()
           }
        }
        .navigationDestination(for: PokemonListItem.self) { pokemon in
            PokemonDetailView(pokemon: pokemon)
        }
        .ignoresSafeArea(edges: .bottom)
        .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
    }
    
    func onSearch() async {
        if searchText.count > 0 {
            await viewModel.fetchPokemonByName(query: searchText)
        } else {
            await viewModel.fetchPokemons()
        }
    }
}

#Preview {
    PokemonGridView()
}
