import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationSplitView {
            SidebarView()
        } content: {
            HabitsView()
        } detail: {
            DetailView()
        }
    }
}



struct DetailView: View {
    var body: some View {
        VStack {
            Text("Detail View")
                .font(.largeTitle)
                .padding()
            
            Text("Select an item from the content list")
                .foregroundColor(.secondary)
        }
        .navigationTitle("Detail")
    }
}

#Preview {
    MainView()
}
