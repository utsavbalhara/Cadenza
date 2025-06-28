import SwiftUI

struct HabitStatsView: View {
    @EnvironmentObject var habitDetailVM: HabitDetailViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Statistics")
                    .font(.headline)
                    .fontWeight(.semibold)
                Spacer()
            }
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                StatCard(
                    title: "Completion Rate",
                    value: String(format: "%.0f%%", habitDetailVM.getCompletionRate() * 100),
                    icon: "percent",
                    color: .blue
                )
                
                StatCard(
                    title: "Total Completed",
                    value: "\(habitDetailVM.getTotalCompletions())",
                    icon: "checkmark.circle.fill",
                    color: .green
                )
                
                StatCard(
                    title: "Current Streak",
                    value: "\(habitDetailVM.getCurrentStreak())",
                    icon: "flame.fill",
                    color: .orange
                )
                
                StatCard(
                    title: "Days Active",
                    value: "\(habitDetailVM.getDaysActive())",
                    icon: "calendar",
                    color: .purple
                )
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.background.secondary)
        )
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.background.tertiary)
        )
    }
}

struct HabitProgressView: View {
    let habit: Habit
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Recent Activity")
                    .font(.headline)
                    .fontWeight(.semibold)
                Spacer()
            }
            
            if habit.entries.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "calendar.badge.plus")
                        .font(.title)
                        .foregroundColor(.gray)
                    
                    Text("No activity yet")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("Complete this habit to start tracking your progress!")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
            } else {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                    ForEach(getRecentDays(), id: \.self) { day in
                        Circle()
                            .fill(getColorForDay(day))
                            .frame(width: 30, height: 30)
                            .overlay(
                                Text("\(Calendar.current.component(.day, from: day))")
                                    .font(.caption2)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                            )
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.background.secondary)
        )
    }
    
    private func getRecentDays() -> [Date] {
        let calendar = Calendar.current
        var days: [Date] = []
        
        for i in 0..<14 {
            if let date = calendar.date(byAdding: .day, value: -i, to: Date()) {
                days.append(date)
            }
        }
        
        return days.reversed()
    }
    
    private func getColorForDay(_ date: Date) -> Color {
        let calendar = Calendar.current
        let hasEntry = habit.entries.contains { calendar.isDate($0.date, inSameDayAs: date) && $0.isCompleted }
        
        if calendar.isDateInToday(date) {
            return habit.isCompletedToday ? habit.category.color : .gray.opacity(0.3)
        } else {
            return hasEntry ? habit.category.color : .gray.opacity(0.3)
        }
    }
}