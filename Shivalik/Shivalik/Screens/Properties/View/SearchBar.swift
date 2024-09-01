import SwiftUI

struct SearchBar: View {
    @Binding var viewModel: PropertyViewModel
    var body: some View {
        HStack {
            TextField("Search...", text: $viewModel.searchText)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
        }
        .frame(height: 40)
    }
}


