//SidebarView.swift

import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

var chevronColor: Color {
    #if canImport(UIKit)
    return Color(uiColor: UIColor.tertiaryLabel)
    #elseif canImport(AppKit)
    return .clear
    #else
    return .gray
    #endif
}


// A single, hashable type to represent any possible selection in the sidebar.
enum SidebarItem: Hashable {
    case today
    case all
    case schedule(NotificationFrequency) // e.g., .schedule(.daily)
    case category(Category)              // e.g., .category(healthCategory)
    
    // A computed property to get a user-friendly title
    var title: String {
        switch self {
        case .today:
            return "Today"
        case .all:
            return "All"
        case .schedule(let frequency):
            // We can make this more descriptive
            switch frequency {
            case .daily: return "Daily Habits"
            case .weekly: return "Weekly Habits"
            case .monthly: return "Monthly Habits"
            }
        case .category(let category):
            return category.name
        }
    }
}

struct SidebarView: View {
    // This view now receives a binding from its parent (MainView).
    @Binding var selection: SidebarItem?
    
    var body: some View {
        // We bind the List's selection directly to the @Binding property.
        // Tapping a row now updates the binding, and NavigationSplitView
        // automatically shows the content view on iOS.
        List(selection: $selection) {
            Section {
                // We now use a simple Label and attach a .tag().
                // The tag's value must match the type of our selection state (SidebarItem).
                // This is the standard, correct pattern for selectable lists.
                HStack {
                    Label {
                        Text("Today")
                    } icon: {
                        Image(systemName: "sun.max")
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.forward")
                        .foregroundColor(chevronColor)
                        .font(.system(size: 14, weight: .semibold))
                }
                .tag(SidebarItem.today)
                
                HStack {
                    Label {
                        Text("All")
                    } icon: {
                        Image(systemName: "tray.full")
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.forward")
                        .foregroundColor(chevronColor)
                        .font(.system(size: 14, weight: .semibold))
                }
                .tag(SidebarItem.all)
            }
            
            Section(header: Text("Schedules")) {
                HStack {
                    Label {
                        Text("Daily Habits")
                    } icon: {
                        Image(systemName: "clock")
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.forward")
                        .foregroundColor(chevronColor)
                        .font(.system(size: 14, weight: .semibold))
                }
                .tag(SidebarItem.schedule(.daily))
                
                HStack {
                    Label {
                        Text("Weekly Habits")
                    } icon: {
                        Image(systemName: "7.circle")
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.forward")
                        .foregroundColor(chevronColor)
                        .font(.system(size: 14, weight: .semibold))
                }
                .tag(SidebarItem.schedule(.weekly))
                
                HStack {
                    Label {
                        Text("Monthly Habits")
                    } icon: {
                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.forward")
                        .foregroundColor(chevronColor)
                        .font(.system(size: 14, weight: .semibold))
                }
                .tag(SidebarItem.schedule(.monthly))
            }
            
            Section(header: Text("Categories")) {
                ForEach(Category.sampleCategories) { category in
                    HStack {
                        Label {
                            Text(category.name)
                        } icon: {
                            Image(systemName: category.icon)
                                .foregroundColor(.blue)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.forward")
                            .foregroundColor(chevronColor)
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .tag(SidebarItem.category(category))
                }
            }
        }
        .listStyle(.sidebar) // Use the .sidebar style for a more native look and feel.
        .navigationTitle("Habits")
    }
}

#Preview {
    // The preview also needs to be updated to provide a dummy state.
    struct PreviewWrapper: View {
        @State private var selection: SidebarItem? = .today
        
        var body: some View {
            NavigationSplitView {
                SidebarView(selection: $selection)
                    .environmentObject(NavigationStore())
            } content: {
                Text("Content View")
            } detail: {
                Text("Detail View")
            }
        }
    }
    
    return PreviewWrapper()
}
