import SwiftUI

struct Header: View {
    
    @Binding var currentPage: Int
    let viewModel: PropertyViewModel

    var body: some View {
        VStack{
            GeometryReader { geometry in
                let bannerWidth = geometry.size.width
                let bannerHeight: CGFloat = 200
                
                TabView(selection: $currentPage) {
                    ForEach(0..<viewModel.categories.count) { index in
                        Image(viewModel.categories[index].image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: bannerWidth, height: bannerHeight)
                            .clipped()
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .onChange(of: currentPage, perform: { newValue in
                    viewModel.fetchItems(at: newValue)
                })
                .frame(width: bannerWidth, height: bannerHeight)
            }
            
            PageControl(numberOfPages: viewModel.categories.count, currentPage: $currentPage)

        }
        .frame(height: 220) 
    }
}
