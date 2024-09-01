//
//  Property.swift
//  Shivalik
//
//  Created by ravi maru on 01/09/24.
//

import Foundation

struct Property: Identifiable, Codable{
    let id: Int
    let type: String
    let title: String
    let description: String
    let image: String
}
