//
//  ShivalikApp.swift
//  Shivalik
//
//  Created by krenil patel on 01/09/24.
//

import SwiftUI

@main
struct ShivalikApp: App {
    var body: some Scene {
        WindowGroup {
            PropertyListView(viewModel: PropertyViewModel())
        }
    }
}
