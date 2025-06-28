import SwiftUI

struct HabitsListView: View {
    @EnvironmentObject var navigationVM: NavigationViewModel
    @EnvironmentObject var categoriesVM: CategoriesViewModel
    @EnvironmentObject var habitsVM: HabitsViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            if habitsVM.filteredHabits.isEmpty {
                EmptyStateView()
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(habitsVM.filteredHabits.indices, id: \.self) { index in
                            HabitCardView(
                                habit: $habitsVM.filteredHabits[index],
                                onToggleCompletion: {
                                    let habit = habitsVM.filteredHabits[index]
                                    habitsVM.toggleHabitCompletion(habit)
                                },
                                onTap: {
                                    let habit = habitsVM.filteredHabits[index]
                                    navigationVM.selectHabit(habit)
                                }
                            )
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(getNavigationTitle())
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    // TODO: Add habit functionality
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    private func getNavigationTitle() -> String {
        if let selectedCategory = navigationVM.selectedCategory {
            return selectedCategory.name
        } else {
            return "All Habits"
        }
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "list.bullet.circle")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("No Habits Yet")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            
            Text("Create your first habit to get started on your journey!")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button("Add Habit") {
                // TODO: Add habit functionality
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}