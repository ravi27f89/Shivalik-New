import SwiftUI

struct ListView: View {
    
    var property: [Property]

    var body: some View {
        VStack(alignment: .leading){
            ForEach(property){ item in
                HStack() {
                    Image(item.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .cornerRadius(5)
                        .clipped() 
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
        }    }
}


