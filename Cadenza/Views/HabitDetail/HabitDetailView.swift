import SwiftUI

struct HabitDetailView: View {
    @EnvironmentObject var navigationVM: NavigationViewModel
    @EnvironmentObject var habitDetailVM: HabitDetailViewModel
    
    var body: some View {
        Group {
            if let habit = navigationVM.selectedHabit {
                ScrollView {
                    VStack(spacing: 24) {
                        HabitHeaderView(habit: habit)
                        
                        HabitStatsView()
                            .environmentObject(habitDetailVM)
                        
                        HabitProgressView(habit: habit)
                        
                        Spacer(minLength: 50)
                    }
                    .padding()
                }
                .navigationTitle(habit.name)
            } else {
                HabitDetailEmptyState()
            }
        }
    }
}

struct HabitHeaderView: View {
    let habit: Habit
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: habit.category.icon)
                    .font(.largeTitle)
                    .foregroundColor(habit.category.color)
                    .frame(width: 60, height: 60)
                    .background(
                        Circle()
                            .fill(habit.category.color.opacity(0.1))
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(habit.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text(habit.category.name)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            
            HStack {
                StatusBadge(
                    title: "Status",
                    value: habit.isCompletedToday ? "Completed" : "Pending",
                    color: habit.isCompletedToday ? .green : .orange
                )
                
                Spacer()
                
                StatusBadge(
                    title: "Streak",
                    value: "\(habit.streak) days",
                    color: .blue
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

struct StatusBadge: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(color)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(color.opacity(0.1))
        )
    }
}

struct HabitDetailEmptyState: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "chart.bar")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("Select a Habit")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            
            Text("Choose a habit from the list to view its details and progress.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}