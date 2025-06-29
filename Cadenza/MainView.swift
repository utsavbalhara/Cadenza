//MainView.swift

import SwiftUI

struct MainView: View {
    @StateObject private var navigationStore = NavigationStore()
    
    // 1. Add this @State variable to own the navigation selection.
    //    It must be optional to work reliably with List(selection:).
    @State private var selection: SidebarItem? = .today
    
    var body: some View {
        NavigationSplitView {
            // 2. Pass a binding to the selection state into the Sidebar.
            SidebarView(selection: $selection)
                .environmentObject(navigationStore)
        } content: {
            HabitsView()
                .environmentObject(navigationStore)
                // 3. When the selection from the sidebar changes, update the
                //    central data store. This triggers the data filtering.
                .onChange(of: selection) { _, newSelection in
                    if let newSelection {
                        navigationStore.selection = newSelection
                    }
                }
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
