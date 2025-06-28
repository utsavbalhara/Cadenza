import SwiftUI

struct CategoryRowView: View {
    let category: Category
    @Binding var selectedCategory: Category?
    
    var isSelected: Bool {
        selectedCategory?.id == category.id
    }
    
    var body: some View {
        HStack {
            Image(systemName: category.icon)
                .foregroundColor(category.color)
                .font(.title2)
                .frame(width: 24, height: 24)
            
            Text(category.name)
                .font(.body)
                .foregroundColor(.primary)
            
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(isSelected ? category.color.opacity(0.1) : Color.clear)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(isSelected ? category.color : Color.clear, lineWidth: 2)
        )
    }
}