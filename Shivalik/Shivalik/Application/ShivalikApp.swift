//
//  ShivalikApp.swift
//  Shivalik
//
//  Created by ravi maru on 01/09/24.
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
