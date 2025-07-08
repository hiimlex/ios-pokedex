//
//  PokemonDetailCardView.swift
//  pokedex
//
//  Created by Adaumi Alex Rodrigues Alves on 08/07/25.
//

import SwiftUI

struct PokemonDetailCardView: View {
    let pokemon: Pokemon
    @State private var selectedTab = "About"
    let tabs = ["About", "Stats", "Moves"]

    
    var body: some View {
        VStack {
            HStack {
                ForEach(Array(tabs.enumerated()), id: \.offset) { (index,tab) in
                    Text(tab)
                        .font(
                            .system(size: 14, weight: selectedTab == tab ? .semibold : .medium, design: .rounded)
                        )
                        .foregroundColor(selectedTab == tab ? .black : .gray)
                        .onTapGesture {
                            selectedTab = tab
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 12)
                        .background(
                            GeometryReader { geo in
                                VStack {
                                    Spacer() // pushes the border to the bottom
                                    if selectedTab == tab {
                                        Rectangle()
                                            .fill(Color.blue)
                                            .frame(height: 2)
                                            .frame(width: geo.size.width * 0.8)
                                    } else {
                                        Rectangle()
                                            .fill(Color.clear)
                                            .frame(height: 2)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                            }
                        )
                    if (index < tabs.count - 1) {
                        Spacer()
                    }
                }
               
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            // Tab group
            VStack (spacing: 12) {
                if selectedTab == "About" {
                    HStack {
                        Text("Weight")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundStyle(Color.gray)
                        Spacer()
                        Text("\(pokemon.weight) eg")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundStyle(Color.black)
                    }
                    HStack {
                        Text("Height")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundStyle(Color.gray)
                        Spacer()
                        Text("\(pokemon.height * 10) cm")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundStyle(Color.black)
                    }
                    HStack {
                        Text("Base Experience")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundStyle(Color.gray)
                        Spacer()
                        Text("\(pokemon.base_experience)")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundStyle(Color.black)
                    }
                } else if selectedTab == "Stats" {
                    ForEach(pokemon.stats) { stat in
                        HStack (spacing: 12) {
                            Text(getStatName(statName: stat.statInfo.name))
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundStyle(Color.gray)
                                .frame(width: 90, alignment: .leading)
                            Text(String(stat.base_stat))
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundStyle(Color.black)
                                .frame(width: 40, alignment: .trailing)
                            ProgressView(value: getStatAsProgress(statBase: stat.base_stat))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                } else if selectedTab == "Moves" {
                    PokemonDetailMovesView(moves: pokemon.moves)
                }
            }
            .padding(12)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight:.infinity, alignment: .topLeading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(6)
        .padding(.top, 24)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        // add negative padding to fill all width
        .padding(-24)
        // add negative on bottom cuz offset set's up this card
        .padding(.bottom, -24)
    }
    
    func getStatName(statName: String) -> String {
        var newStatName = statName.replacingOccurrences(of: "-", with: "")
        newStatName = newStatName.replacingOccurrences(of: "special", with: "sp. ")
        
        
        return newStatName.capitalized
    }
    
    func getStatAsProgress(statBase: Int) -> Double {
        let statTotalCalc: Double = 150
        let percentage = Double(statBase) / statTotalCalc
        
        return percentage
    }
}
