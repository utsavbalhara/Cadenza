import SwiftUI

struct HabitCard: View {
    let habit: Habit
    @State private var isCompleted: Bool = false
    
    var body: some View {
        HStack(alignment: .center) {
            // Left side content
            VStack(alignment: .leading, spacing: 1.2) {
                // Habit name - top left
                Text(habit.name)
                    .font(.system(size: 17, weight: .bold, design: .default))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                // Streak component - bottom left
                VStack(alignment: .leading, spacing: 0) {
                    // Streak number and flame
                    HStack(alignment: .center, spacing: 4) {
                        Text("\(habit.streak)")
                            .font(.system(size: 22, weight: .bold, design: .default))
                        Image(systemName: "flame.fill")
                            .font(.system(size: 14, weight: .regular, design: .default))
                            .foregroundColor(.blue.opacity(isCompleted ? 1.0 : 0.4))
                    }
                    
                    // "DAYS" text
                    Text("DAYS")
                        .font(.system(size: 8, weight: .regular))
                        .textCase(.uppercase)
                        .foregroundColor(.primary.opacity(0.6))

                }
                .frame(height: 36, alignment: .topLeading)
            }
            
            Spacer()
            
            // Right side - checkmark
            Button(action: {
                withAnimation(.none) {
                    isCompleted.toggle()
                }
            }) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 40, weight: .regular, design: .default))
                    .foregroundColor(isCompleted ? .blue : Color.secondary.opacity(0.2))
            }
            .buttonStyle(.plain)
        }
        .padding(16)
        .frame(width: 377, height: 96)
        .background(isCompleted ? .blue.opacity(0.1) : .clear)
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(isCompleted ? .clear : Color.secondary.opacity(0.2), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }
}

// Color extension for hex colors
//extension Color {
//    init(hex: String) {
//        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
//        var int: UInt64 = 0
//        Scanner(string: hex).scanHexInt64(&int)
//        let a, r, g, b: UInt64
//        switch hex.count {
//        case 3: // RGB (12-bit)
//            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
//        case 6: // RGB (24-bit)
//            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
//        case 8: // ARGB (32-bit)
//            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
//        default:
//            (a, r, g, b) = (1, 1, 1, 0)
//        }
//
//        self.init(
//            .sRGB,
//            red: Double(r) / 255,
//            green: Double(g) / 255,
//            blue:  Double(b) / 255,
//            opacity: Double(a) / 255
//        )
//    }
//}

#Preview {
    HabitCard(habit: Habit.sampleHabits[0])
        .padding()
}
