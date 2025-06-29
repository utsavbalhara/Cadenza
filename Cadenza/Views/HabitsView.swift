import SwiftUI

struct HabitsView: View {
    var body: some View {
        List {
            Text("Content Item 1")
            Text("Content Item 2")
            Text("Content Item 3")
        }
        .navigationTitle("Content")
    }
}

#Preview {
    HabitsView()
}