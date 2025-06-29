import Foundation

// Notification frequency options
enum NotificationFrequency: String, CaseIterable {
    case daily = "Daily"
    case weekly = "Weekly" 
    case monthly = "Monthly"
}

// Main habit model
struct Habit: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var category: Category
    var isCompletedToday: Bool = false
    var streak: Int = 0
    var entries: [HabitEntry] = []
    var createdDate: Date = Date()
    var minimumNotificationFrequency: NotificationFrequency = .daily
    
    // Calculate completion percentage
    var completionRate: Double {
        guard !entries.isEmpty else { return 0.0 }
        let completedEntries = entries.filter { $0.isCompleted }
        return Double(completedEntries.count) / Double(entries.count)
    }
    
    // Count completed entries
    var totalCompletions: Int {
        entries.filter { $0.isCompleted }.count
    }
    
    static let sampleHabits: [Habit] = [
        Habit(
            name: "Drink 8 glasses of water",
            category: Category.sampleCategories[0], // Health
            entries: generateSampleEntries(days: 10, completedCount: 10)
        ),
        Habit(
            name: "Exercise for 30 minutes",
            category: Category.sampleCategories[1], // Fitness
            entries: generateSampleEntries(days: 8, completedCount: 4)
        ),
        Habit(
            name: "Read for 20 minutes",
            category: Category.sampleCategories[3], // Learning
            entries: generateSampleEntries(days: 12, completedCount: 9)
        ),
        Habit(
            name: "Meditate",
            category: Category.sampleCategories[4], // Mindfulness
            entries: generateSampleEntries(days: 5, completedCount: 3)
        ),
        Habit(
            name: "Complete daily tasks",
            category: Category.sampleCategories[2], // Productivity
            entries: generateSampleEntries(days: 6, completedCount: 5)
        ),
        Habit(
            name: "Call a friend",
            category: Category.sampleCategories[5], // Social
            entries: generateSampleEntries(days: 3, completedCount: 2)
        )
    ]
    
    private static func generateSampleEntries(days: Int, completedCount: Int) -> [HabitEntry] {
        var entries: [HabitEntry] = []
        let calendar = Calendar.current
        
        for i in 0..<days {
            let date = calendar.date(byAdding: .day, value: -i, to: Date()) ?? Date()
            let isCompleted = i < completedCount
            entries.append(HabitEntry(date: date, isCompleted: isCompleted))
        }
        
        return entries.sorted { $0.date > $1.date }
    }
}
