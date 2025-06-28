// Import SwiftUI for all UI components
import SwiftUI

// Main navigation container that sets up the three-pane layout
struct MainNavigationView: View {
    // @StateObject creates and owns ViewModel instances
    // These ViewModels live for the lifetime of this view
    
    // Navigation state management (selected category, selected habit)
    @StateObject private var navigationVM = NavigationViewModel()
    // Categories data and operations
    @StateObject private var categoriesVM = CategoriesViewModel()
    // Habits data and operations (CRUD, completion toggling)
    @StateObject private var habitsVM = HabitsViewModel()
    // Habit detail analytics and statistics
    @StateObject private var habitDetailVM = HabitDetailViewModel()
    
    var body: some View {
        // NavigationSplitView creates the three-pane layout
        // Automatically adapts to different platforms and screen sizes
        NavigationSplitView {
            // SIDEBAR: Categories and filters
            CategoriesView()
                // Pass navigation state to categories view
                .environmentObject(navigationVM)
                // Pass categories data to categories view
                .environmentObject(categoriesVM)
                // Pass habits data for counting habits per category
                .environmentObject(habitsVM)
        } content: {
            // CONTENT: List of habits (filtered by selected category)
            HabitsListView()
                // Pass navigation state for habit selection
                .environmentObject(navigationVM)
                // Pass categories data for display
                .environmentObject(categoriesVM)
                // Pass habits data for display and completion toggling
                .environmentObject(habitsVM)
        } detail: {
            // DETAIL: Selected habit's details, stats, and analytics
            HabitDetailView()
                // Pass navigation state to know which habit is selected
                .environmentObject(navigationVM)
                // Pass habit detail ViewModel for analytics
                .environmentObject(habitDetailVM)
        }
        // React to category selection changes
        .onChange(of: navigationVM.selectedCategory) { _, newCategory in
            // When category changes, filter the habits list
            habitsVM.filterByCategory(newCategory)
        }
        // React to habit selection changes
        .onChange(of: navigationVM.selectedHabit) { _, newHabit in
            // When a habit is selected, update the detail ViewModel
            if let habit = newHabit {
                // Set the selected habit in detail ViewModel for analytics
                habitDetailVM.setHabit(habit)
            }
        }
    }
}