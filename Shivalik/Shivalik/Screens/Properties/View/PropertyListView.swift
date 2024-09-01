//
//  ContentView.swift
//  Shivalik
//
//  Created by ravi maru on 01/09/24.
//

import SwiftUI

struct PropertyListView: View {
    @ObservedObject var viewModel: PropertyViewModel
    @State private var showingActionSheet = false
    @State private var currentPage = 0
    //@Binding var searchText: String

    var body: some View {
        NavigationView {
                ZStack{
                    ScrollView {
                    VStack(alignment: .leading) {
                        headerview
                        searchbar
                        //SearchBar(searchText: $viewModel.searchText) // Add the SearchBar here
                        listView
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
                            floatingButton
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
    var headerview: some View{
        VStack {
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
                .onChange(of: currentPage, { oldValue, newValue in
                    print(oldValue, newValue)
                    viewModel.fetchItems(at: newValue)
                })
                .frame(width: bannerWidth, height: bannerHeight)
                
                pageControl
            }
        }
        .frame(height: 250) // Adjust as needed
    }
    
    var listView: some View {
        VStack(alignment: .leading){
            ForEach(viewModel.properties){ item in
                HStack() {
                    Image(item.image) // Load image from bundle using the name
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .cornerRadius(5)
                        .clipped() // Optional: Clips the image to its frame
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.headline)
                        Text(item.description)
                            .font(.subheadline)
                            .lineLimit(2)
                    }
                }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .padding(.horizontal)
            }
            Spacer()
        }
    }
    
    var searchbar: some View{
            HStack {
                TextField("Search...", text: $viewModel.searchText)
                    .padding(7)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
            }
            .frame(height: 40)
    }
    
    var floatingButton: some View{
        Button(action: {
            showingActionSheet = true
        }, label: {
            Image(systemName: "ellipsis")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .tint(.white)
                .clipShape(Circle())
                .shadow(radius: 10)
        })
    }
    
    var pageControl: some View{
        VStack {
            HStack(spacing: 8) {
                ForEach(0..<viewModel.categories.count, id: \.self) { page in
                    Circle()
                        .fill(page == currentPage ? Color.blue : Color.gray)
                        .frame(width: 8, height: 8)
                }
            }
            .padding(.top, 8)
            .frame(maxWidth: .infinity)
            .padding(.top, 210)
        }
    }
}
