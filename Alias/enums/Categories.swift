//
//  Categories 2.swift
//  Alias
//
//  Created by lilit on 15.01.26.
//

enum Categories: String, CaseIterable, CodingKey {
    case animals
    case fruits
    case vegetables
    case colors
    
    
    var displayName: String {
        return self.rawValue
    }
}

struct JsonCategories: Codable {
    let animals: [String]
    let fruits: [String]
    let vegetables: [String]
    let colors: [String]
    let gameRules: String
    
    func forKey(for key: String) -> String {
        switch key {
        case "gameRules": return gameRules
        default: return ""
        }
    }
    func words(for category: Categories) -> [String] {
        switch category {
        case .animals: return animals
        case .fruits: return fruits
        case .vegetables: return vegetables
        case .colors: return colors
        }
    }
    
    
}
