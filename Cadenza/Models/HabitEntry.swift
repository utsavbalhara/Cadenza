// Import Foundation to access Date type and other basic data types
import Foundation

// HabitEntry represents a single day's record for a habit
// Identifiable: allows SwiftUI to track entries in lists
// Hashable: allows entries to be used in Sets and as Dictionary keys
struct HabitEntry: Identifiable, Hashable {
    // Unique identifier for each entry - required by Identifiable protocol
    let id = UUID()
    
    // The date this entry represents (which day the habit was tracked)
    var date: Date
    
    // Boolean flag indicating whether the habit was completed on this date
    var isCompleted: Bool
    
    // Optional note that users can add to describe their experience
    // String? means this can be nil (no note) or contain text
    var note: String?
    
    // Custom initializer with default values for convenience
    // This allows creating entries with minimal parameters
    init(date: Date = Date(), isCompleted: Bool = false, note: String? = nil) {
        // Set the date property to the provided date (defaults to current date)
        self.date = date
        // Set completion status (defaults to false/not completed)
        self.isCompleted = isCompleted
        // Set the optional note (defaults to nil/no note)
        self.note = note
    }
}