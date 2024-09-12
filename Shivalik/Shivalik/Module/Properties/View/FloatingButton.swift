import SwiftUI

struct FloatingButton: View {
    @Binding var showingActionSheet: Bool
    var body: some View {
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
}

