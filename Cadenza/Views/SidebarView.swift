import SwiftUI

struct SidebarView: View {
    var body: some View {
        List {
            Section {
                HStack {
                    Image(systemName: "sun.max")
                        .foregroundColor(.blue)
                    Text("Today")
                }
                HStack {
                    Image(systemName: "tray.full")
                        .foregroundColor(.blue)
                    Text("All")
                }
            }
            
            Section(header: Text("Schedules")) {
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(.blue)
                    Text("Daily Habits")
                }
                HStack {
                    Image(systemName: "7.circle")
                        .foregroundColor(.blue)
                    Text("Weekly Habits")
                }
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.blue)
                    Text("Monthly Habits")
                }
            }
            
            Section(header: Text("Categories")) {
                ForEach(Category.sampleCategories) { category in
                    HStack {
                        Image(systemName: category.icon)
                            .foregroundColor(.blue)
                        Text(category.name)
                    }
                }
            }
        }
        .navigationTitle("Habits")
        #if os(macOS)
        .safeAreaInset(edge: .bottom) {
            HStack {
                Button(action: { /* add category */ }) {
                    HStack(spacing: 4) {
                        Image(systemName: "plus.circle")
                        Text("New Category")
                    }
                }
                .buttonStyle(.borderless)
                Spacer()
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
        }
        #else
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: { /* add category */ }) {
                    Image(systemName: "checklist")
                }
            }
        }
        #endif
    }
}

#Preview {
    SidebarView()
}
