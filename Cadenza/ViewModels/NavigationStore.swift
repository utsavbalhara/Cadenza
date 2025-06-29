// NavigationStore.swift

import SwiftUI
import Combine

class NavigationStore: ObservableObject {
    // SINGLE source of truth for the app's current state.
    // We initialize it to `.today` as the default selection.
    @Published var selection: SidebarItem = .today {
        didSet {
        }
    }
    
    init() {
    }
    
    // Get filtered habits based on the new `selection` property
    var filteredHabits: [Habit] {
        
        switch selection {
        case .today, .all:
            return Habit.sampleHabits
            
        case .schedule(let frequency):
            return Habit.sampleHabits.filter { $0.minimumNotificationFrequency == frequency }
            
        case .category(let category):
            return Habit.sampleHabits.filter { $0.category.id == category.id }
        }
    }
}
