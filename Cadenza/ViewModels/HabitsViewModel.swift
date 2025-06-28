// Import SwiftUI for UI components
import SwiftUI
// Import Combine for ObservableObject and @Published
import Combine

// @MainActor ensures all UI updates happen on the main thread
@MainActor
class HabitsViewModel: ObservableObject {
    // @Published array containing all habits - this is our main data source
    // Initialized with sample data from Habit.sampleHabits
    @Published var habits: [Habit] = Habit.sampleHabits
    
    // @Published array containing filtered habits based on category selection
    // This is what the UI displays - subset of habits array
    @Published var filteredHabits: [Habit] = []
    
    // Initializer runs when ViewModel is created
    init() {
        // Initially show all habits (no filter applied)
        filteredHabits = habits
    }
    
    // Function to toggle completion status of a habit
    func toggleHabitCompletion(_ habit: Habit) {
        // Find the habit in our main array using its unique ID
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            // Toggle the completion status for today
            habits[index].isCompletedToday.toggle()
            
            // If habit was just marked as completed
            if habits[index].isCompletedToday {
                // Increment the streak counter
                habits[index].streak += 1
                // Create a new entry for today marked as completed
                let entry = HabitEntry(date: Date(), isCompleted: true)
                // Add this entry to the habit's history
                habits[index].entries.append(entry)
            } else {
                // If habit was unmarked (uncompleted)
                // Decrease streak but don't go below 0
                habits[index].streak = max(0, habits[index].streak - 1)
                // Find today's entry in the entries array
                if let lastEntryIndex = habits[index].entries.lastIndex(where: { Calendar.current.isDateInToday($0.date) }) {
                    // Mark today's entry as not completed
                    habits[index].entries[lastEntryIndex].isCompleted = false
                }
            }
        }
        // Update the filtered list to reflect changes
        updateFilteredHabits()
    }
    
    // Function to add a new habit to the collection
    func addHabit(_ habit: Habit) {
        // Add the new habit to the main habits array
        habits.append(habit)
        // Update the filtered list to include the new habit
        updateFilteredHabits()
    }
    
    // Function to remove a habit from the collection
    func removeHabit(_ habit: Habit) {
        // Remove all habits with matching ID from the main array
        habits.removeAll { $0.id == habit.id }
        // Update the filtered list to reflect the removal
        updateFilteredHabits()
    }
    
    // Function to filter habits by category
    func filterByCategory(_ category: Category?) {
        // If a specific category is selected
        if let category = category {
            // Filter habits to only show those matching the selected category
            filteredHabits = habits.filter { $0.category.id == category.id }
        } else {
            // If no category selected (nil), show all habits
            filteredHabits = habits
        }
    }
    
    // Private helper function to update filtered habits
    private func updateFilteredHabits() {
        // Currently just copies all habits to filtered list
        // In a real app, this would preserve any active filters
        filteredHabits = habits
    }
}