// Import SwiftUI for all UI components
import SwiftUI

// Sidebar view showing categories and filters for habit navigation
struct CategoriesView: View {
    // Access to navigation state (which category is selected)
    @EnvironmentObject var navigationVM: NavigationViewModel
    // Access to categories data and operations
    @EnvironmentObject var categoriesVM: CategoriesViewModel
    // Access to habits data for counting habits per category
    @EnvironmentObject var habitsVM: HabitsViewModel
    
    var body: some View {
        // Vertical container for the entire sidebar content
        VStack(alignment: .leading, spacing: 0) {
            // List container for all category options
            List {
                // First section: "All Habits" option
                Section {
                    // Button for selecting "All Habits" (shows all habits, no filter)
                    Button(action: {
                        // Set selected category to nil (means show all)
                        navigationVM.selectCategory(nil)
                    }) {
                        // Horizontal layout for "All Habits" row
                        HStack {
                            // List icon to represent "all habits"
                            Image(systemName: "list.bullet")
                                // Blue color for the icon
                                .foregroundColor(.blue)
                                // Medium-large font size
                                .font(.title2)
                                // Fixed frame for consistent alignment
                                .frame(width: 24, height: 24)
                            
                            // "All Habits" text label
                            Text("All Habits")
                                // Body font size
                                .font(.body)
                                // Primary color (adapts to light/dark mode)
                                .foregroundColor(.primary)
                            
                            // Push count badge to the right
                            Spacer()
                            
                            // Badge showing total number of habits
                            Text("\(habitsVM.habits.count)")
                                // Small caption font
                                .font(.caption)
                                // Secondary color for less emphasis
                                .foregroundColor(.secondary)
                                // Horizontal padding inside the badge
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Capsule())
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(navigationVM.selectedCategory == nil ? Color.blue.opacity(0.1) : Color.clear)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(navigationVM.selectedCategory == nil ? Color.blue : Color.clear, lineWidth: 2)
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                } header: {
                    Text("Overview")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Section {
                    ForEach(categoriesVM.categories) { category in
                        Button(action: {
                            navigationVM.selectCategory(category)
                        }) {
                            HStack {
                                CategoryRowView(category: category, selectedCategory: $navigationVM.selectedCategory)
                                
                                Spacer()
                                
                                Text("\(getHabitCount(for: category))")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.gray.opacity(0.2))
                                    .clipShape(Capsule())
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                } header: {
                    Text("Categories")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .listStyle(SidebarListStyle())
        }
        .navigationTitle("Categories")
    }
    
    private func getHabitCount(for category: Category) -> Int {
        habitsVM.habits.filter { $0.category.id == category.id }.count
    }
}