//
//  PropertyViewModel.swift
//  Shivalik
//
//  Created by ravi maru on 01/09/24.
//

import Foundation
import Combine

class PropertyViewModel: ObservableObject {
    @Published var properties: [Property] = []
    private var allProperties: [Property] = []
    @Published var categories: [Category] = []

    @Published var searchText: String = "" {
        didSet {
            filterItems()
        }
    }

    init() {
        fetchCategory()
        fetchItems(at: 0)
    }
    
    func fetchCategory() {
        guard let url = Bundle.main.url(forResource: "Categories", withExtension: "json") else {
            print("Failed to locate items.json in bundle.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedList = try JSONDecoder().decode([Category].self, from: data)
            self.categories = decodedList
        } catch {
            print("Failed to decode items.json: \(error)")
        }
    }
    
    func fetchItems(at index: Int) {
        guard let url = Bundle.main.url(forResource: "Properties", withExtension: "json") else {
            print("Failed to locate items.json in bundle.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedList = try JSONDecoder().decode([Property].self, from: data)
            self.properties = decodedList.filter { $0.type == categories[index].title}
            self.allProperties = properties
        } catch {
            print("Failed to decode items.json: \(error)")
        }
    }
    
    private func filterItems() {
        if searchText.isEmpty {
            properties = allProperties
        } else {
            properties = allProperties.filter { item in
                item.title.lowercased().contains(searchText.lowercased()) ||
                item.description.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func fetchOccurance() -> String{
        var topOccurance = ""
        let arr = allProperties.map{$0.title}

        let combinedString = arr.joined().lowercased()
        var characterCount: [Character: Int] = [:]

        for char in combinedString {
            characterCount[char, default: 0] += 1
        }
        
        let sortedCharacters = characterCount.sorted { $0.value > $1.value }.prefix(3)
        //let top3Characters = sortedCharacters.prefix(3)
                
        for (char, count) in sortedCharacters {
            topOccurance = topOccurance + "\(char.uppercased()): \(count) \n"
        }

        return topOccurance
    }

}
