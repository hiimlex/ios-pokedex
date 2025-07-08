//
//  PokemonDetailMovesView.swift
//  pokedex
//
//  Created by Adaumi Alex Rodrigues Alves on 08/07/25.
//

import SwiftUI

struct PokemonDetailMovesView: View {
    var moves: [PokemonMovesListItem]
    
    var body: some View {
        HStack{
            Text("Name")
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundStyle(Color.gray)
                .frame(width: 120, alignment: .leading)
            Spacer()
            Text("Type")
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundStyle(Color.gray)
                .frame(width: 80, alignment: .center)
            Spacer()
            Text("Learned At")
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundStyle(Color.gray)
                .frame(width: 80, alignment: .trailing)
        }
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                ForEach(moves) { move in
                    HStack {
                        PokemonMoveView(move: move)
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
//                    .background(Color.gray)
//                    .clipShape(
//                        RoundedRectangle(cornerRadius: 12)
//                    )
                }
            }
        }
    }
}

#Preview {
    PokemonDetailMovesView(moves: [
        PokemonMovesListItem(
            moveInfo: PokemonMove(name: "whirlwind", url: "https://pokeapi.co/api/v2/move/18/"),
            versionGroupDetails: [
                PokemonVersionGroupDetail(
                    level_learned_at: 18,
                    move_learn_method: PokemonMoveLearnMethod(name: "Asd")
                )
            ]
        )
    ]
    )
}


