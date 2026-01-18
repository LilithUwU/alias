//  LanguageUtil.swift
import SwiftUI
import Combine

class LanguageUtil: ObservableObject {
    
    init() {}
    
    private func getLanguageFileName() -> String {
        switch Locale.current.language.languageCode?.identifier ?? "en" {
        case "hy":return  "armenian"
        case "ru":return  "russian"
        default:return  "english"
        }
    }
    
    func loadJSON(category: Categories) -> [String]? {
        let fileName = getLanguageFileName()
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
              let jsonData = try? Data(contentsOf: url)
        else {print("JSON file not found: \(fileName).json")
            return nil}
        do {
            let data = try JSONDecoder().decode(JsonCategories.self, from: jsonData)
            return data.words(for: category)
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
    
    func getRulesFromJSON(key: String) -> String {
        let fileName = getLanguageFileName()

        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
              let jsonData = try? Data(contentsOf: url) else {
            print("JSON file not found: \(fileName).json")
            return ""
        }
        
        do {
            let data = try JSONDecoder().decode(JsonCategories.self, from: jsonData)
            return data.forKey(for: key)
        } catch {
            print("Error decoding JSON: \(error)")
            return "Error reading JSON"
        }
    }
}

