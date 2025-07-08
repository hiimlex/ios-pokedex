//
//  ContentView.swift
//  pokedex
//
//  Created by Adaumi Alex Rodrigues Alves on 07/07/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var search = ""
    
    var body: some View {
        NavigationStack{
            PokemonGridView()
        }
    }
    
    init() {
        setTitleStyle()
    }
    
    func setTitleStyle() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        appearance.largeTitleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 32, weight: .bold)
            
        ]
        UINavigationBar.appearance().standardAppearance = appearance
    }
}

#Preview {
    ContentView()
}
