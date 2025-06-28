// Import SwiftUI for all UI components
import SwiftUI

// Individual habit card component that displays habit info and completion controls
struct HabitCardView: View {
    // @Binding creates a two-way connection to the habit data
    // Changes here will update the parent view's data
    @Binding var habit: Habit
    
    // Closure that gets called when user toggles completion
    let onToggleCompletion: () -> Void
    
    // Closure that gets called when user taps the card (not the checkbox)
    let onTap: () -> Void
    
    // @State tracks whether the card is currently being pressed for visual feedback
    @State private var isPressed = false
    
    var body: some View {
        // Horizontal stack containing checkbox, habit info, and streak indicator
        HStack(spacing: 16) {
            // Completion checkbox button
            Button(action: onToggleCompletion) {
                // SF Symbol that changes based on completion status
                Image(systemName: habit.isCompletedToday ? "checkmark.circle.fill" : "circle")
                    // Medium-large font size for easy tapping
                    .font(.title2)
                    // Color changes: category color when completed, gray when not
                    .foregroundColor(habit.isCompletedToday ? habit.category.color : .gray)
                    // Smooth animation when completion status changes
                    .animation(.easeInOut(duration: 0.2), value: habit.isCompletedToday)
            }
            // Remove default button styling to avoid visual interference
            .buttonStyle(PlainButtonStyle())
            
            // Vertical stack containing habit name and metadata
            VStack(alignment: .leading, spacing: 4) {
                // Habit name with dynamic strikethrough
                Text(habit.name)
                    // Prominent font for the main text
                    .font(.headline)
                    // Primary color adapts to light/dark mode
                    .foregroundColor(.primary)
                    // Strike through text when completed
                    .strikethrough(habit.isCompletedToday)
                    // Animate strikethrough change
                    .animation(.easeInOut(duration: 0.2), value: habit.isCompletedToday)
                
                // Horizontal stack containing category info and streak
                HStack {
                    // Category icon and name group
                    HStack(spacing: 4) {
                        // Category icon using SF Symbol
                        Image(systemName: habit.category.icon)
                            // Small caption font
                            .font(.caption)
                            // Use category's theme color
                            .foregroundColor(habit.category.color)
                        // Category name text
                        Text(habit.category.name)
                            // Small caption font
                            .font(.caption)
                            // Secondary color for less emphasis
                            .foregroundColor(.secondary)
                    }
                    
                    // Push streak indicator to the right
                    Spacer()
                    
                    // Only show streak if it's greater than 0
                    if habit.streak > 0 {
                        // Streak indicator with flame icon and number
                        HStack(spacing: 4) {
                            // Fire emoji icon to represent streak
                            Image(systemName: "flame.fill")
                                // Small caption font
                                .font(.caption)
                                // Orange color for "fire" theme
                                .foregroundColor(.orange)
                            // Streak number as text
                            Text("\(habit.streak)")
                                // Small caption font
                                .font(.caption)
                                // Medium weight for emphasis
                                .fontWeight(.medium)
                                // Orange color to match icon
                                .foregroundColor(.orange)
                        }
                    }
                }
            }
            
            // Push all content to the left side
            Spacer()
        }
        // Add padding around the entire card content
        .padding(16)
        // Card background styling
        .background(
            // Rounded rectangle shape
            RoundedRectangle(cornerRadius: 12)
                // Secondary background color (adapts to light/dark mode)
                .fill(.background.secondary)
                // Subtle shadow for depth
                .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
        )
        // Scale effect for press feedback (slightly smaller when pressed)
        .scaleEffect(isPressed ? 0.98 : 1.0)
        // Animate the scale change smoothly
        .animation(.easeInOut(duration: 0.1), value: isPressed)
        // Handle tap on the entire card (not just checkbox)
        .onTapGesture {
            // Call the tap handler passed from parent
            onTap()
        }
        // Handle press state for visual feedback
        .onLongPressGesture(minimumDuration: 0) { pressing in
            // Update pressed state when user presses/releases
            isPressed = pressing
        } perform: {}
        // Swipe actions for iOS-style completion toggle
        .swipeActions(edge: .trailing) {
            // Swipe action button
            Button {
                // Toggle completion when swiped
                onToggleCompletion()
            } label: {
                // Dynamic label based on current completion status
                Label("Complete", systemImage: habit.isCompletedToday ? "xmark" : "checkmark")
            }
            // Dynamic color: red for uncompleting, green for completing
            .tint(habit.isCompletedToday ? .red : .green)
        }
    }
}