//
//  PokemonCardView.swift
//  pokedex
//
//  Created by Adaumi Alex Rodrigues Alves on 07/07/25.
//

import SwiftUI

struct PokemonCardView: View {
    let pokemon: PokemonListItem
    @State private var pokemonData: Pokemon? = nil
    var backgroundColor: Color? = nil
    
    
    var body: some View {
        VStack(spacing: 12) {
            if let data = pokemonData {
                AsyncImage(
                    url: URL(string: data.sprites.other.officialArtwork.front_default))
                    { image in
                        image.resizable().frame(width: 120, height: 120)
                    } placeholder: {
                        ProgressView()
                    }
                    .zIndex(1)
                    .offset(y: 12)
                Text(data.name.capitalized)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color(UIColor.label))
                Text(getIdAsNumber(id: data.id))
                    .font(.system(size:14, weight: .medium, design: .rounded))
                    .foregroundStyle(Color(UIColor.label).opacity(0.6))
             
            }
        }
        .padding(12)
        .padding(.top, 0)
        .frame(maxWidth: .infinity, alignment: .bottom)
        .background(
            backgroundGradient(for: pokemonData)
        )
        .cornerRadius(12)
        .task {
            await loadPokemonData()
        }
    }
    
    func getIdAsNumber(id: Int) -> String {
        let idStr = String(id)
        
        switch idStr.count {
        case 1:
            return "#00\(idStr)"
        case 2:
            return "#0\(idStr)"
        case 3:
            return "#\(idStr)"
        default:
            return ""
        }
    }
    
    
    func backgroundGradient(for pokemon: Pokemon?) -> LinearGradient {
        //        if no pokemon data than return gray
        guard let pokemon = pokemonData else {
            return LinearGradient(colors: [Color.gray.opacity(0.1)], startPoint: .top, endPoint: .bottom)
        }
        //        map colors to linear gradient
        let colors = pokemon.types
            .map {PokemonTypeColor.color(for: $0.typeInfo.name).opacity(0.4)}
        
        return LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    func loadPokemonData() async {
        if let data = await fetchPokemonData(pokemonUrl: pokemon.url) {
            self.pokemonData = data
        }
    }
}

#Preview {
    PokemonCardView(
        pokemon: PokemonListItem(
            name: "pikachu",
            url: "https://pokeapi.co/api/v2/pokemon/25/")
    )
}
