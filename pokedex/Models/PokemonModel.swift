//
//  PokemonCardModel.swift
//  pokedex
//
//  Created by Adaumi Alex Rodrigues Alves on 07/07/25.
//

import Foundation

@MainActor
class PokemonCardModel: ObservableObject {
    @Published var pokemons: [PokemonListItem] = []
    
    func fetchPokemonByName(query: String? = nil) async {
        let searchValue: String = query?.lowercased() ?? ""
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(searchValue)") else {
            print("Invalid URL")
            return
        }
        do{
            let (data,response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Pokémon not found")
                self.pokemons = []
                return
            }
            let single = try JSONDecoder().decode(Pokemon.self, from: data)

            self.pokemons = [PokemonListItem(name: single.name, url: "https://pokeapi.co/api/v2/pokemon/\(single.name.lowercased())")]
        } catch {
            print("Error fetching pokemon: \(error)")
            self.pokemons = []
        }
            
    }

    func fetchPokemons() async {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?offset=0&limit=155") else {
            print("Invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(PokemonAPIResponse.self, from: data)
            self.pokemons = response.results
            
        } catch {
            print("Error fetching cards: \(error)")
            self.pokemons = []
        }
    }
}

struct PokemonAPIResponse: Codable {
    let results: [PokemonListItem]
}

func fetchPokemonData(pokemonUrl: String) async -> Pokemon? {
    guard let url = URL(string: pokemonUrl) else {
        print("Invalid URL \(pokemonUrl)")
        return nil
    }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(Pokemon.self, from: data)
        
        return response
    } catch {
        print("Error fetching pokemon data: \(error)")
        return nil
    }
}

func fetchPokemonMove(moveUrl: String) async -> PokemonMoveResponse? {
    guard let url = URL(string: moveUrl) else {
        print("Invalid move url \(moveUrl)")
        return nil
    }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(PokemonMoveResponse.self, from: data)
        
        return response
    } catch {
        print("Error fetching move data: \(error)")
        return nil
    }
}

