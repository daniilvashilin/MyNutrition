import Foundation

struct Nutrition: Identifiable {
    var id: String // userID (or documentID)
    var caloriesGoal: Int
    var proteinGoal: Int
    var fatGoal: Int
    var carbsGoal: Int
    var sugarGoal: Int
    var fiberGoal: Int
    var weightGoal: Int
    var current: CurrentNutrition
    var history: [DailyNutrition]
    var lastResetDate: Date

    struct CurrentNutrition {
        var caloriesConsumed: Int
        var proteinConsumed: Int
        var fatConsumed: Int
        var carbsConsumed: Int
        var sugarConsumed: Int
        var fiberConsumed: Int
        var move: Int
        var exerciseMinutes: Int
        var steps: Int
    }

    struct DailyNutrition {
        var date: Date
        var caloriesConsumed: Int
        var proteinConsumed: Int
        var fatConsumed: Int
        var carbsConsumed: Int
        var sugarConsumed: Int
        var fiberConsumed: Int
        var move: Int
        var exerciseMinutes: Int
        var steps: Int
    }
}
