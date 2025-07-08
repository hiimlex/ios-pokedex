//
//  SearchBarView.swift
//  pokedex
//
//  Created by Adaumi Alex Rodrigues Alves on 07/07/25.
//

import SwiftUI

struct SearchBarView: View {
    
    @State private var search: String = ""
    
    var body: some View {
            TextField("Search for pokemon", text: $search)
                .padding(12)
                .background(
                    Color.gray.opacity(0.2)
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .font(.system(size:16, weight: .medium, design: .rounded))
    }
}

#Preview {
    SearchBarView()
}
