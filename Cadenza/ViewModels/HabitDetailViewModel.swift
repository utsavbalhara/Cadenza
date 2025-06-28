import SwiftUI
import Combine

@MainActor
class HabitDetailViewModel: ObservableObject {
    @Published var selectedHabit: Habit?
    
    func setHabit(_ habit: Habit) {
        selectedHabit = habit
    }
    
    func getCompletionRate() -> Double {
        selectedHabit?.completionRate ?? 0.0
    }
    
    func getTotalCompletions() -> Int {
        selectedHabit?.totalCompletions ?? 0
    }
    
    func getCurrentStreak() -> Int {
        selectedHabit?.streak ?? 0
    }
    
    func getRecentEntries(limit: Int = 7) -> [HabitEntry] {
        guard let habit = selectedHabit else { return [] }
        return Array(habit.entries.suffix(limit))
    }
    
    func getDaysActive() -> Int {
        guard let habit = selectedHabit else { return 0 }
        let calendar = Calendar.current
        let daysSinceCreation = calendar.dateComponents([.day], from: habit.createdDate, to: Date()).day ?? 0
        return max(1, daysSinceCreation + 1)
    }
}