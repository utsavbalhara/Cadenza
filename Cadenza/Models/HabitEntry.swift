import Foundation

// Daily habit completion record
struct HabitEntry: Identifiable, Hashable {
    let id = UUID() // Unique identifier
    var date: Date // Entry date
    var isCompleted: Bool // Completion status
    var note: String? // Optional user note
}