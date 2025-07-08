//
//  PokemonStruct.swift
//  pokedex
//
//  Created by Adaumi Alex Rodrigues Alves on 07/07/25.
//

import Foundation
import SwiftUI

struct PokemonListItem: Codable, Identifiable, Hashable {
    var id: String { name }
    let name: String
    let url: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: PokemonListItem, rhs: PokemonListItem) -> Bool {
        return lhs.name == lhs.name
    }
}


struct Pokemon: Codable, Identifiable {
    var id: Int
    let name: String
    let types: [PokemonType]
    let weight: Int
    let sprites: PokemonSprites
    let base_experience: Int
    let height: Int
    let stats: [PokemonStat]
    let moves: [PokemonMovesListItem]
}

struct PokemonStat: Identifiable, Codable {
    var id: String { statInfo.name }
    let base_stat: Int
    let effort: Int
    let statInfo: StatInfo
    
    enum CodingKeys: String, CodingKey {
       case base_stat
        case effort
       case statInfo = "stat"
    }
    
    struct StatInfo: Codable {
        let name: String
    }

}

struct PokemonMovesListItem: Identifiable, Codable {
    var id: String { moveInfo.name }
    let moveInfo: PokemonMove
    let versionGroupDetails: [PokemonVersionGroupDetail]
    
    enum CodingKeys: String, CodingKey {
        case moveInfo = "move"
        case versionGroupDetails = "version_group_details"
    }
}

struct PokemonMove: Codable {
    let name: String
    let url: String
}

struct PokemonVersionGroupDetail: Codable {
    let level_learned_at: Int
    let move_learn_method: PokemonMoveLearnMethod
}

struct PokemonMoveLearnMethod: Codable {
    let name: String
}


struct PokemonSprites: Codable {
    let back_default: String
    let front_default: String
    let other: OthersSprites

    struct OthersSprites: Codable {
        let officialArtwork: OfficialArtwork
        
        enum CodingKeys: String, CodingKey {
            case officialArtwork = "official-artwork"
        }
        
        
        struct OfficialArtwork: Codable {
            let front_default: String
        }
    }
}

struct PokemonSpritesType: Codable {
    let front_default: String
    let back_default: String
}

struct PokemonType: Identifiable, Codable {
    var id: String { typeInfo.name }
    let slot: Int
    let typeInfo: TypeInfo
    
    enum CodingKeys: String, CodingKey {
       case slot
       case typeInfo = "type"
    }

   struct TypeInfo: Codable {
       let name: String
       let url: String
   }
}

struct PokemonMoveResponse: Codable, Identifiable {
    let id: Int
    let name: String
    let power: Int?
    let pp: Int
    let type: MoveType
 
    struct MoveType: Codable {
        let name: String
    }
}

enum PokemonTypeColor {
    static func color(for typeName: String) -> Color {
        switch typeName.lowercased() {
        case "grass":
            return Color.green
        case "fire":
            return Color.red
        case "water":
            return Color.blue
        case "electric":
            return Color.yellow
        case "poison":
            return Color.purple
        case "bug":
            return Color(hex: "#C0FC58")
        case "normal":
            return Color.gray
        case "flying":
            return Color(hex: "#efefef")
        case "ice":
            return Color(hex: "#5FB2D0")
        case "rock":
            return Color(hex: "#313131")
        case "ground":
            return Color(hex: "#313131")
        case "ghost":
            return Color.purple
        case "steel":
            return Color(hex: "#ececec")
        case "psychic":
            return Color.pink
        case "dragon":
            return Color.orange
        case "fighting":
            return Color.red
        default:
            return Color.gray
        }
    }
}
