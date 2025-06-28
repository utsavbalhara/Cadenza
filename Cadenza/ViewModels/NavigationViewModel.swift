// Import SwiftUI for NavigationPath and other UI components
import SwiftUI
// Import Combine for ObservableObject and @Published property wrapper
import Combine

// @MainActor ensures all UI updates happen on the main thread
// This is required for ObservableObject classes that update UI
@MainActor
class NavigationViewModel: ObservableObject {
    // @Published property wrapper automatically notifies SwiftUI views when this changes
    // Optional Category - nil means "All Habits" is selected
    @Published var selectedCategory: Category?
    
    // @Published property for currently selected habit in the detail view
    // Optional Habit - nil means no habit is selected
    @Published var selectedHabit: Habit?
    
    // NavigationPath manages the navigation stack for programmatic navigation
    // Currently not used but available for future navigation features
    @Published var navigationPath = NavigationPath()
    
    // Function to select a category and update the UI
    func selectCategory(_ category: Category?) {
        // Update the selected category (could be nil for "All Habits")
        selectedCategory = category
        // Clear habit selection when changing categories
        // This ensures detail view shows empty state when switching categories
        selectedHabit = nil
    }
    
    // Function to select a specific habit for the detail view
    func selectHabit(_ habit: Habit) {
        // Update the selected habit - this will trigger detail view to show habit info
        selectedHabit = habit
    }
    
    // Function to clear all selections and return to initial state
    func clearSelection() {
        // Clear category selection (goes back to "All Habits")
        selectedCategory = nil
        // Clear habit selection (detail view shows empty state)
        selectedHabit = nil
    }
}