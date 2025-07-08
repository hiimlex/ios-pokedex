//
//  PokemonMoveView.swift
//  pokedex
//
//  Created by Adaumi Alex Rodrigues Alves on 08/07/25.
//

import SwiftUI

struct PokemonMoveView: View {
    var move: PokemonMovesListItem
    @State private var moveData: PokemonMoveResponse? = nil
    
    var learnedAt: Int {
        get {
            return self.move.versionGroupDetails[0].level_learned_at
        }
    }
    
    var body: some View {
        HStack {
            if let data = moveData {
                Text(getMoveName(moveName:data.name))
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundStyle(Color.black)
                    .frame(width: 120, alignment: .leading)
                Spacer()
                Text(data.type.name)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundStyle(Color.black)
                    .padding(6)
                    .frame(width: 80, alignment: .center)
                    .background(PokemonTypeColor.color(for: data.type.name).opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                Spacer()
                Text(String(move.versionGroupDetails[0].level_learned_at))
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundStyle(Color.black)
                    .frame(width: 80, alignment: .trailing)
            } else {
                ProgressView()
                    .padding(12)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .task {
            await loadMoveData()
        }
    }
    
    func getMoveName(moveName: String) -> String {
        var newMoveName = moveName.replacingOccurrences(of: "-", with: " ")

        return newMoveName.capitalized
    }
    
    func loadMoveData() async {
        if let data = await fetchPokemonMove(moveUrl: move.moveInfo.url){
            self.moveData = data
        }
    }
}

#Preview {
    PokemonMoveView(
        move: PokemonMovesListItem(
            moveInfo: PokemonMove(name: "whirlwind", url: "https://pokeapi.co/api/v2/move/18/"),
            versionGroupDetails: [
                PokemonVersionGroupDetail(
                    level_learned_at: 18,
                    move_learn_method: PokemonMoveLearnMethod(name: "Asd")
                )
            ]
        )
    )
}
