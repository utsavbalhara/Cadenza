# Habit Tracker App - Complete Technical Overview

## 🏗️ Architecture & Structure

### **MVVM Architecture**
- **Models**: Data structures (Category, Habit, HabitEntry)
- **ViewModels**: Business logic with @MainActor and ObservableObject
- **Views**: SwiftUI components with environment object injection
- **Navigation**: Three-pane NavigationSplitView layout

### **File Organization**
```
Cadenza/
├── Models/
│   ├── Category.swift
│   ├── Habit.swift
│   └── HabitEntry.swift
├── ViewModels/
│   ├── NavigationViewModel.swift
│   ├── CategoriesViewModel.swift
│   ├── HabitsViewModel.swift
│   └── HabitDetailViewModel.swift
└── Views/
    ├── Navigation/
    │   └── MainNavigationView.swift
    ├── Categories/
    │   ├── CategoriesView.swift
    │   └── CategoryRowView.swift
    ├── Habits/
    │   ├── HabitsListView.swift
    │   └── HabitCardView.swift
    └── HabitDetail/
        ├── HabitDetailView.swift
        └── HabitStatsView.swift
```

## 📊 Data Models

### **Category**
```swift
struct Category: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var color: Color
    var icon: String // SF Symbol name
    static let sampleCategories: [Category] // 6 predefined categories
}
```

**Sample Categories:**
- Health (green, heart.fill)
- Fitness (orange, figure.run)
- Productivity (blue, briefcase.fill)
- Learning (purple, book.fill)
- Mindfulness (indigo, brain.head.profile)
- Social (pink, person.2.fill)

### **HabitEntry**
```swift
struct HabitEntry: Identifiable, Hashable {
    let id = UUID()
    var date: Date
    var isCompleted: Bool
    var note: String? // Optional user note
}
```

### **Habit**
```swift
struct Habit: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var category: Category
    var isCompletedToday: Bool = false
    var streak: Int = 0
    var entries: [HabitEntry] = []
    var createdDate: Date = Date()
    
    // Computed properties
    var completionRate: Double // Percentage of completed entries
    var totalCompletions: Int // Count of completed entries
    
    static let sampleHabits: [Habit] // 6 habits with historical data
}
```

**Sample Habits:**
- "Drink 8 glasses of water" (Health, 10 days history, 7/10 completed)
- "Exercise for 30 minutes" (Fitness, 8 days history, 4/8 completed)
- "Read for 20 minutes" (Learning, 12 days history, 9/12 completed)
- "Meditate" (Mindfulness, 5 days history, 3/5 completed)
- "Complete daily tasks" (Productivity, 6 days history, 5/6 completed)
- "Call a friend" (Social, 3 days history, 2/3 completed)

## 🧠 ViewModels Logic

### **NavigationViewModel**
Manages selected category and habit state, coordinates three-pane navigation.

**Properties:**
```swift
@Published var selectedCategory: Category?
@Published var selectedHabit: Habit?
@Published var navigationPath = NavigationPath()
```

**Key Functions:**
- `selectCategory(_ category: Category?)` - Updates filter, clears habit selection
- `selectHabit(_ habit: Habit)` - Sets habit for detail view
- `clearSelection()` - Resets all selections

### **HabitsViewModel**
Manages all habits data and operations, handles completion toggling with streak calculation.

**Properties:**
```swift
@Published var habits: [Habit] = Habit.sampleHabits
@Published var filteredHabits: [Habit] = []
```

**Key Functions:**
- `toggleHabitCompletion(_ habit: Habit)` - Updates completion, streak, and entries
- `filterByCategory(_ category: Category?)` - Filters habits list
- `addHabit(_ habit: Habit)` - CRUD operation
- `removeHabit(_ habit: Habit)` - CRUD operation

**Completion Logic:**
1. Toggle `isCompletedToday` boolean
2. If completed: increment streak, add HabitEntry(completed: true)
3. If uncompleted: decrement streak (min 0), mark today's entry as false

### **CategoriesViewModel**
Manages category data and selection state.

**Properties:**
```swift
@Published var categories: [Category] = Category.sampleCategories
@Published var selectedCategory: Category?
```

**Key Functions:**
- `selectCategory(_ category: Category?)` - Updates selection
- `addCategory(_ category: Category)` - CRUD operation
- `removeCategory(_ category: Category)` - CRUD operation

### **HabitDetailViewModel**
Processes selected habit for analytics and statistics.

**Properties:**
```swift
@Published var selectedHabit: Habit?
```

**Key Functions:**
- `setHabit(_ habit: Habit)` - Updates selected habit
- `getCompletionRate()` - Returns percentage
- `getTotalCompletions()` - Returns count
- `getCurrentStreak()` - Returns streak value
- `getRecentEntries(limit: Int)` - Returns recent completion history
- `getDaysActive()` - Days since creation

## 🗂️ Navigation Structure

### **Three-Pane Layout**
```swift
NavigationSplitView {
    // SIDEBAR: Categories
    CategoriesView()
        .environmentObject(navigationVM)
        .environmentObject(categoriesVM)
        .environmentObject(habitsVM)
} content: {
    // CONTENT: Filtered habits list
    HabitsListView()
        .environmentObject(navigationVM)
        .environmentObject(categoriesVM)
        .environmentObject(habitsVM)
} detail: {
    // DETAIL: Selected habit analytics
    HabitDetailView()
        .environmentObject(navigationVM)
        .environmentObject(habitDetailVM)
}
```

### **Platform Adaptation**
- **iOS (iPhone)**: Collapsed to single view with push/pop navigation
- **iPadOS Portrait**: Two-column (compact width) with slide-over detail
- **iPadOS Landscape**: Three-column (regular width) with all panes visible
- **macOS**: Always three-column with resizable panes and sidebar toggle

### **State Flow**
1. User selects category → NavigationVM updates → HabitsVM filters habits
2. User selects habit → NavigationVM updates → HabitDetailVM updates analytics
3. User toggles completion → HabitsVM updates data → UI reflects changes

### **Change Observers**
```swift
.onChange(of: navigationVM.selectedCategory) { _, newCategory in
    habitsVM.filterByCategory(newCategory)
}
.onChange(of: navigationVM.selectedHabit) { _, newHabit in
    if let habit = newHabit {
        habitDetailVM.setHabit(habit)
    }
}
```

## 🎯 Core Functionality

### **Habit Completion System**
- **Primary Method**: Checkbox button in habit cards
- **Secondary Method**: Swipe actions (iOS/iPadOS only)
- **Visual Feedback**: Strikethrough text, color changes, smooth animations
- **Data Updates**: Updates `isCompletedToday`, `streak`, and `entries` array
- **Streak Logic**: Increments on completion, decrements on uncomplete (minimum 0)

### **Filtering System**
- Categories sidebar with "All Habits" special option
- Real-time filtering of habits list based on selection
- Habit count badges displayed per category
- Selection state persistence during app session

### **Statistics Calculation**
- **Completion Rate**: `completedEntries.count / totalEntries.count * 100`
- **Current Streak**: Consecutive days completed
- **Total Completions**: Count of all completed entries across time
- **Days Active**: Calendar days since habit creation date

### **Mock Data Generation**
- 6 predefined categories with distinct colors and SF Symbol icons
- 6 sample habits with realistic names and varying historical data (3-12 days)
- Completion patterns generated using date arithmetic (subtracting days from current date)
- Different completion rates per habit for demonstration purposes

## 🔗 Component Communication

### **Environment Object Injection Pattern**
```swift
// MainNavigationView creates ViewModels
@StateObject private var navigationVM = NavigationViewModel()
@StateObject private var categoriesVM = CategoriesViewModel()
@StateObject private var habitsVM = HabitsViewModel()
@StateObject private var habitDetailVM = HabitDetailViewModel()

// Child views receive via @EnvironmentObject
@EnvironmentObject var navigationVM: NavigationViewModel
@EnvironmentObject var habitsVM: HabitsViewModel
```

### **Data Flow Pattern**
```
User Action → View Event → ViewModel Function → Model Update → @Published Change → UI Refresh
```

### **Key Binding Patterns**
- `@Binding var habit: Habit` in HabitCardView for real-time updates
- `@Published` properties in ViewModels trigger automatic UI updates
- `onChange` modifiers coordinate state between ViewModels

## 🎛️ Interaction Patterns

### **Habit Card Interactions**
- **Tap checkbox**: Immediately toggle completion status
- **Tap card area**: Navigate to habit detail view
- **Swipe right**: Alternative completion toggle (iOS/iPadOS)
- **Press feedback**: Visual scale animation (0.98x scale when pressed)

### **Category Selection**
- **Tap category**: Filter habits list to show only that category
- **Tap "All Habits"**: Remove filter, display all habits
- **Visual feedback**: Selection highlighting with category color
- **Count badges**: Show number of habits per category

### **Cross-Platform Gestures**
- **iOS/iPadOS**: Full swipe gesture support enabled
- **macOS**: Click-only interactions, keyboard navigation ready for implementation

## 🎨 Visual Components

### **HabitCardView Structure**
```
[Checkbox] [Habit Name + Category Info] [Streak Badge]
           [Strikethrough when completed]
```

### **Categories Sidebar Structure**
```
Overview
├── All Habits (count)

Categories  
├── Health (count)
├── Fitness (count)
├── Productivity (count)
├── Learning (count)
├── Mindfulness (count)
└── Social (count)
```

### **Habit Detail Analytics**
- Completion status badge
- Current streak display
- Statistics grid (completion rate, total completions, streak, days active)
- Recent activity calendar view (14-day grid)

## 🗄️ Data Persistence

### **Current Implementation**
- **Storage**: In-memory only, no Core Data or file persistence
- **Sample Data**: Static arrays with realistic mock data
- **Session Lifecycle**: Data resets completely on app restart
- **State Management**: @Published properties handle UI updates

### **Architecture for Future Persistence**
- ViewModels structured for easy Core Data integration
- CRUD operations abstracted and ready for database layer
- Model structs conform to Identifiable and Hashable
- Can easily add Codable conformance for JSON serialization

### **Extension Points**
```swift
// Ready for persistence layer
protocol HabitRepository {
    func saveHabit(_ habit: Habit)
    func loadHabits() -> [Habit]
    func deleteHabit(id: UUID)
}

// ViewModel can inject repository
class HabitsViewModel: ObservableObject {
    private let repository: HabitRepository
    // Current logic remains the same
}
```

## 🚀 Implementation Guide

### **Step 1: Create Models**
1. Define Category struct with Identifiable, Hashable
2. Define HabitEntry struct for daily records
3. Define Habit struct with computed properties
4. Add static sample data arrays

### **Step 2: Build ViewModels**
1. NavigationViewModel for state coordination
2. HabitsViewModel for data operations and completion logic
3. CategoriesViewModel for category management
4. HabitDetailViewModel for analytics

### **Step 3: Construct Views**
1. MainNavigationView with NavigationSplitView
2. CategoriesView with List and Section structure
3. HabitsListView with LazyVStack of cards
4. HabitCardView with complex interaction handling
5. HabitDetailView with statistics display

### **Step 4: Wire Communication**
1. @StateObject creation in MainNavigationView
2. @EnvironmentObject injection to child views
3. onChange observers for state coordination
4. @Binding for real-time card updates

### **Step 5: Platform Testing**
1. Test three-pane behavior on macOS
2. Verify adaptive layout on iPadOS
3. Confirm collapsed navigation on iPhone
4. Validate swipe gestures work only on touch platforms

This architecture provides a complete, scalable foundation for a cross-platform habit tracking application using modern SwiftUI patterns and MVVM architecture.