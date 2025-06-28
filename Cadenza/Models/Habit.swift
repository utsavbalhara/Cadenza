// Import Foundation for Date type and other core functionality
import Foundation

// Habit represents a single habit that users want to track
// Identifiable: allows SwiftUI to track habits in lists
// Hashable: allows habits to be used in Sets and as Dictionary keys
struct Habit: Identifiable, Hashable {
    // Unique identifier for each habit - required by Identifiable protocol
    let id = UUID()
    
    // User-defined name for this habit (e.g., "Drink water", "Exercise")
    var name: String
    
    // Category this habit belongs to (Health, Fitness, etc.)
    var category: Category
    
    // Boolean flag indicating if the habit was completed today
    // Defaults to false when creating new habits
    var isCompletedToday: Bool = false
    
    // Current streak count (consecutive days completed)
    // Defaults to 0 for new habits
    var streak: Int = 0
    
    // Array storing all historical completion records
    // Defaults to empty array for new habits
    var entries: [HabitEntry] = []
    
    // Date when this habit was first created
    // Defaults to current date when creating new habits
    var createdDate: Date = Date()
    
    // Computed property that calculates completion percentage
    var completionRate: Double {
        // Guard statement: if entries array is empty, return 0% completion
        guard !entries.isEmpty else { return 0.0 }
        
        // Filter the entries array to get only completed entries
        let completedEntries = entries.filter { $0.isCompleted }
        
        // Calculate percentage: completed entries / total entries
        // Convert to Double for decimal precision
        return Double(completedEntries.count) / Double(entries.count)
    }
    
    // Computed property that counts total number of completed days
    var totalCompletions: Int {
        // Filter entries to only completed ones and count them
        entries.filter { $0.isCompleted }.count
    }
    
    // Static property that creates sample habits with mock data
    // This is a closure that gets executed once and returns an array of habits
    static let sampleHabits: [Habit] = {
        // Get the current calendar for date calculations
        let calendar = Calendar.current
        // Create empty array to store our sample habits
        var habits: [Habit] = []
        
        // Create first habit: water drinking habit
        // Uses Health category (index 0) and sets initial streak to 5
        var waterHabit = Habit(name: "Drink 8 glasses of water", category: Category.sampleCategories[0], streak: 5)
        // Generate 10 days of historical data going backwards from today
        for i in 0..<10 {
            // Calculate date by subtracting i days from today
            if let date = calendar.date(byAdding: .day, value: -i, to: Date()) {
                // Create entry: completed if i < 7 (so 7 out of 10 days completed)
                waterHabit.entries.append(HabitEntry(date: date, isCompleted: i < 7))
            }
        }
        // Add the water habit to our habits array
        habits.append(waterHabit)
        
        // Create second habit: exercise habit
        // Uses Fitness category (index 1) and sets initial streak to 3
        var exerciseHabit = Habit(name: "Exercise for 30 minutes", category: Category.sampleCategories[1], streak: 3)
        // Generate 8 days of historical data
        for i in 0..<8 {
            // Calculate date by subtracting i days from today
            if let date = calendar.date(byAdding: .day, value: -i, to: Date()) {
                // Create entry: completed if i < 4 (so 4 out of 8 days completed)
                exerciseHabit.entries.append(HabitEntry(date: date, isCompleted: i < 4))
            }
        }
        // Add exercise habit to our habits array
        habits.append(exerciseHabit)
        
        // Create third habit: reading habit
        // Uses Learning category (index 3) and sets initial streak to 7
        var readHabit = Habit(name: "Read for 20 minutes", category: Category.sampleCategories[3], streak: 7)
        // Generate 12 days of historical data (longer history for this habit)
        for i in 0..<12 {
            // Calculate date by subtracting i days from today
            if let date = calendar.date(byAdding: .day, value: -i, to: Date()) {
                // Create entry: completed if i < 9 (so 9 out of 12 days completed)
                readHabit.entries.append(HabitEntry(date: date, isCompleted: i < 9))
            }
        }
        // Add reading habit to our habits array
        habits.append(readHabit)
        
        // Create fourth habit: meditation habit
        // Uses Mindfulness category (index 4) and sets initial streak to 2
        var meditateHabit = Habit(name: "Meditate", category: Category.sampleCategories[4], streak: 2)
        // Generate 5 days of historical data (shorter history for newer habit)
        for i in 0..<5 {
            // Calculate date by subtracting i days from today
            if let date = calendar.date(byAdding: .day, value: -i, to: Date()) {
                // Create entry: completed if i < 3 (so 3 out of 5 days completed)
                meditateHabit.entries.append(HabitEntry(date: date, isCompleted: i < 3))
            }
        }
        // Add meditation habit to our habits array
        habits.append(meditateHabit)
        
        // Create fifth habit: productivity habit
        // Uses Productivity category (index 2) and sets initial streak to 4
        var tasksHabit = Habit(name: "Complete daily tasks", category: Category.sampleCategories[2], streak: 4)
        // Generate 6 days of historical data
        for i in 0..<6 {
            // Calculate date by subtracting i days from today
            if let date = calendar.date(byAdding: .day, value: -i, to: Date()) {
                // Create entry: completed if i < 5 (so 5 out of 6 days completed)
                tasksHabit.entries.append(HabitEntry(date: date, isCompleted: i < 5))
            }
        }
        // Add tasks habit to our habits array
        habits.append(tasksHabit)
        
        // Create sixth habit: social habit
        // Uses Social category (index 5) and sets initial streak to 1
        var socialHabit = Habit(name: "Call a friend", category: Category.sampleCategories[5], streak: 1)
        // Generate 3 days of historical data (shortest history)
        for i in 0..<3 {
            // Calculate date by subtracting i days from today
            if let date = calendar.date(byAdding: .day, value: -i, to: Date()) {
                // Create entry: completed if i < 2 (so 2 out of 3 days completed)
                socialHabit.entries.append(HabitEntry(date: date, isCompleted: i < 2))
            }
        }
        // Add social habit to our habits array
        habits.append(socialHabit)
        
        // Return the completed array of sample habits
        return habits
    }() // Immediately execute this closure to create the static property
}
