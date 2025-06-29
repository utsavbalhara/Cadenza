import SwiftUI

struct HabitsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(Habit.sampleHabits) { habit in
                    HabitCard(habit: habit)
                }
            }
            .padding()
        }
        .navigationTitle("Habits")
    }
}

#Preview {
    HabitsView()
}