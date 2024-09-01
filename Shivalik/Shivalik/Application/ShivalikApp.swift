import SwiftUI

@main
struct ShivalikApp: App {
    var body: some Scene {
        WindowGroup {
            PropertyListView(viewModel: PropertyViewModel())
        }
    }
}
