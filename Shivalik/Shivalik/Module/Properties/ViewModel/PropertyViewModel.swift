import Foundation
import Combine

class PropertyViewModel: ObservableObject {
    @Published var response: PropertyModel?
    @Published var selectedProperty: [Property] = []
    @Published var filteredProperty: [Property] = []

    @Published var searchText: String = "" {
        didSet {
            fetchSearchedItems()
        }
    }

    init() {
        fetchPropertyData()
    }
    
    private func fetchPropertyData() {
        DataLoader().loadData { propertyModel in
            self.response = propertyModel
        }
    }

    func fetchProperty(at index: Int) {
        searchText = ""
        selectedProperty = self.response?.property.filter{ $0.type == self.response?.category[index].title} ?? []
    }
    
    private func fetchSearchedItems() {
        if !searchText.isEmpty {
            filteredProperty = selectedProperty.filter { item in
                item.title.lowercased().contains(searchText.lowercased()) ||
                item.description.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func fetchOccurance() -> String{
        var topOccurance = ""
        let combinedString = selectedProperty.map{$0.title}.joined().lowercased()
        var characterCount: [Character: Int] = [:]

        for char in combinedString {
            characterCount[char, default: 0] += 1
        }
        
        let sortedCharacters = characterCount.sorted { $0.value > $1.value }.prefix(3)
        for (char, count) in sortedCharacters {
            topOccurance = topOccurance + "\(char.uppercased()): \(count) \n"
        }
        return topOccurance
    }
}
