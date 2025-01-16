import Foundation

struct Nutrition: Identifiable {
    var id: String // userID (or documentID)
    var caloriesGoal: Double
    var proteinGoal: Double
    var fatGoal: Double
    var carbsGoal: Double
    var sugarGoal: Double
    var fiberGoal: Double
    var goalWeight: Double // Целевой вес
    var currentWeight: Double // Текущий вес
    var weightHistory: [WeightEntry] // История веса
    var current: CurrentNutrition
    var history: [DailyNutrition]
    var lastResetDate: Date

    struct CurrentNutrition {
        var caloriesConsumed: Double
        var proteinConsumed: Double
        var fatConsumed: Double
        var carbsConsumed: Double
        var sugarConsumed: Double
        var fiberConsumed: Double
        var move: Double
        var exerciseMinutes: Double
        var steps: Double
    }

    struct DailyNutrition {
        var date: Date
        var caloriesConsumed: Double
        var proteinConsumed: Double
        var fatConsumed: Double
        var carbsConsumed: Double
        var sugarConsumed: Double
        var fiberConsumed: Double
        var move: Double
        var exerciseMinutes: Double
        var steps: Double
    }

    struct WeightEntry: Identifiable {
        var id: String = UUID().uuidString // Уникальный идентификатор записи
        var date: Date // Дата записи веса
        var weight: Double // Значение веса
    }
}
