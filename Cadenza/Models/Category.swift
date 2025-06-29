import SwiftUI

// Category model for habit organization
struct Category: Identifiable, Hashable {
    let id = UUID() // Unique identifier
    var name: String // Category display name
    var color: Color // UI theme color
    var icon: String // SF Symbol name
    
    // Predefined categories with colors and outline icons
    static let sampleCategories: [Category] = [
        Category(name: "Health", color: .green, icon: "heart"),
        Category(name: "Fitness", color: .orange, icon: "figure.run"),
        Category(name: "Productivity", color: .blue, icon: "briefcase"),
        Category(name: "Learning", color: .purple, icon: "book"),
        Category(name: "Mindfulness", color: .indigo, icon: "brain.head.profile"),
        Category(name: "Social", color: .pink, icon: "person.2")
    ]
}