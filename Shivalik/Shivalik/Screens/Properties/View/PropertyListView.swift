import SwiftUI

struct PropertyListView: View {
    @ObservedObject var viewModel: PropertyViewModel
    @State private var showingActionSheet = false
    @State private var currentPage = 0
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView {
                    VStack(alignment: .leading) {
                        Header(currentPage: $currentPage, viewModel: viewModel)
                        SearchBar(viewModel: .constant(viewModel))
                        ListView(viewModel: viewModel)
                            .onAppear {
                                viewModel.fetchCategory()
                                viewModel.fetchItems(at: currentPage)
                            }
                        
                    }.navigationTitle(viewModel.categories[currentPage].title)
                }
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        FloatingButton(showingActionSheet: $showingActionSheet)
                            .padding([.trailing, .bottom])
                            .actionSheet(isPresented: $showingActionSheet) {
                                ActionSheet(
                                    title: Text(viewModel.categories[currentPage].title),
                                    message: Text(viewModel.fetchOccurance()),
                                    buttons: [
                                        .cancel()
                                    ]
                                )
                            }
                    }
                }
            }
        }
    }
}
