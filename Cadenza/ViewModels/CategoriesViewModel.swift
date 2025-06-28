import SwiftUI
import Combine

@MainActor
class CategoriesViewModel: ObservableObject {
    @Published var categories: [Category] = Category.sampleCategories
    @Published var selectedCategory: Category?
    
    func selectCategory(_ category: Category?) {
        selectedCategory = category
    }
    
    func addCategory(_ category: Category) {
        categories.append(category)
    }
    
    func removeCategory(_ category: Category) {
        categories.removeAll { $0.id == category.id }
    }
}