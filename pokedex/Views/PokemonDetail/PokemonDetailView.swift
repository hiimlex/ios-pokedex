//
//  PokemonDetailView.swift
//  pokedex
//
//  Created by Adaumi Alex Rodrigues Alves on 07/07/25.
//

import SwiftUI

struct PokemonDetailView: View {
    var pokemon: PokemonListItem
    @State private var pokemonData: Pokemon? = nil
    

    
    var body: some View {
        VStack(alignment: .leading, spacing: 18){
            if let data = pokemonData {
                HStack(alignment: .firstTextBaseline) {
                    Text(data.name.capitalized)
                        .font(.system(size: 32, weight: .bold, design: .rounded ))
                        .foregroundStyle(Color.white)
                    
                    Spacer()
                    Text(getIdAsNumber(id: data.id))
                        .font(.system(size: 20, weight: .semibold, design: .rounded ))
                        .foregroundStyle(Color.white)
                }
                HStack(spacing: 12) {
                    ForEach(data.types) { type in
                        Text(type.typeInfo.name.capitalized)
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color.white)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .frame(alignment: .center)
                            .background(PokemonTypeColor.color(for: type.typeInfo.name).opacity(0.6))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                VStack(spacing:0){
                    HStack(alignment: .center) {
                        AsyncImage(
                            url: URL(string: data.sprites.other.officialArtwork.front_default))
                        { image in
                            image.resizable().frame(width: 240, height: 240)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                    .zIndex(1)
                    .offset(y: 24)
                    PokemonDetailCardView(pokemon: data)
                        
                }
                .offset(y: -24)
            }
            
        }
            .task {
                await loadPokemonData()
            }
            .padding(24)
            .ignoresSafeArea(edges: .bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(backgroundByPokemonType(for: pokemonData))
        
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.light, for: .navigationBar)
            
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
    
    func backgroundByPokemonType(for pokemon: Pokemon?) -> Color {
        //        if no pokemon data than return gray
        guard let pokemon = pokemonData else {
            return PokemonTypeColor.color(for: "")
        }
       
        return PokemonTypeColor.color(for: pokemon.types[0].typeInfo.name).opacity(0.6)
    }
    
    
    func loadPokemonData() async {
        if let data = await fetchPokemonData(pokemonUrl: pokemon.url) {
            self.pokemonData = data
        }
    }
    
}

#Preview {
    PokemonDetailView(pokemon: PokemonListItem(
        name: "ivysaur",
        url: "https://pokeapi.co/api/v2/pokemon/2/")
    )
}
