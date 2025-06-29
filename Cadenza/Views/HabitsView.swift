// HabitsView.swift

import SwiftUI

struct HabitsView: View {
    @EnvironmentObject var navigationStore: NavigationStore
    
    var body: some View {
        let habits = navigationStore.filteredHabits
        
        // Create a Group to hold the logic and attach the modifier to it.
        // This is a clean way to apply modifiers to conditional content.
        Group {
            if habits.isEmpty {
                VStack {
                    Image(systemName: "moon.stars.fill")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 4)
                    Text("No Habits Found")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("No habits match the '\(navigationStore.selection.title)' filter.")
                        .font(.callout)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
            } else {
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(habits) { habit in
                            HabitCard(habit: habit)
                        }
                    }
                    .padding()
                }
            }
        }
        // The modifier is inside the body, applied to the Group.
        .navigationTitle(navigationStore.selection.title)
    }
}

#Preview {
    // For previewing
    NavigationView {
        HabitsView()
            .environmentObject(NavigationStore())
    }
}
