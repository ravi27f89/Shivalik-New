import Foundation

struct Property: Identifiable, Codable{
    let id: Int
    let type: String
    let title: String
    let description: String
    let image: String
}
