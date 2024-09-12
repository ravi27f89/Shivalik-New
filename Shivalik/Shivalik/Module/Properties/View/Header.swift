import SwiftUI

struct Header: View {
    
    @Binding var currentPage: Int
    var category: [Category]?

    var body: some View {
        VStack{
            GeometryReader { geometry in
                let bannerWidth = geometry.size.width
                let bannerHeight: CGFloat = 200
                
                TabView(selection: $currentPage) {
                    if let category = category {
                        ForEach(0..<category.count, id: \.self) { index in
                            Image(category[index].image )
                                .resizable()
                                .scaledToFill()
                                .frame(width: bannerWidth, height: bannerHeight)
                                .clipped()
                                .tag(index)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(width: bannerWidth, height: bannerHeight)
            }
            
            PageControl(numberOfPages: category?.count ?? 0, currentPage: $currentPage)

        }
        .frame(height: 220) 
    }
}
