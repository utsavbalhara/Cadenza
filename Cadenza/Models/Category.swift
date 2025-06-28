// Import SwiftUI framework to access Color type and other UI components
import SwiftUI

// Define Category struct that represents a habit category
// Identifiable: allows SwiftUI to track this in lists and forEach loops using the id property
// Hashable: allows this struct to be used in Sets and as Dictionary keys
struct Category: Identifiable, Hashable {
    // Unique identifier for each category - SwiftUI uses this to track items in lists
    let id = UUID()
    
    // Human-readable name for the category (e.g., "Health", "Fitness")
    var name: String
    
    // SwiftUI Color used for visual theming throughout the app
    var color: Color
    
    // SF Symbol name used as the icon for this category
    var icon: String
    
    // Static array containing predefined categories for the app
    // This serves as our mock data since we're not using persistence
    static let sampleCategories: [Category] = [
        // Health category with green theme and heart icon
        Category(name: "Health", color: .green, icon: "heart.fill"),
        // Fitness category with orange theme and running figure icon
        Category(name: "Fitness", color: .orange, icon: "figure.run"),
        // Productivity category with blue theme and briefcase icon
        Category(name: "Productivity", color: .blue, icon: "briefcase.fill"),
        // Learning category with purple theme and book icon
        Category(name: "Learning", color: .purple, icon: "book.fill"),
        // Mindfulness category with indigo theme and brain icon
        Category(name: "Mindfulness", color: .indigo, icon: "brain.head.profile"),
        // Social category with pink theme and people icon
        Category(name: "Social", color: .pink, icon: "person.2.fill")
    ]
}