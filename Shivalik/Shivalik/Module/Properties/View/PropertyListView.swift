import SwiftUI

struct PropertyListView: View {
    @State private var showingActionSheet = false
    @State private var currentPage = 0
    @StateObject var viewModel = PropertyViewModel()

    private var property: [Property] {
        return viewModel.searchText.isEmpty ? viewModel.selectedProperty : viewModel.filteredProperty
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView {
                    VStack(alignment: .leading) {
                        Header(currentPage: $currentPage, category: viewModel.response?.category ?? [])
                        .onChange(of: currentPage, perform: { newValue in
                            viewModel.fetchProperty(at: newValue)
                        })
                        SearchBar(searchText: $viewModel.searchText)
                        ListView(property: property)
                            .onAppear {
                                viewModel.fetchProperty(at: currentPage)
                            }
                    }
                }
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        FloatingButton(showingActionSheet: $showingActionSheet)
                            .padding([.trailing, .bottom])
                            .actionSheet(isPresented: $showingActionSheet) {
                                ActionSheet(
                                    title: Text(viewModel.response?.category[currentPage].title ?? ""),
                                    message: Text(viewModel.fetchOccurance()),
                                    buttons: [
                                        .cancel()
                                    ]
                                )
                            }
                    }
                }
            }
            .navigationTitle(viewModel.response?.category[currentPage].title ?? "")
        }
    }
}

