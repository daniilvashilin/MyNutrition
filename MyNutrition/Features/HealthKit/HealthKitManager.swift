

import Foundation
import HealthKit

@MainActor
class HealthKitManager: ObservableObject {
    private let healthStore = HKHealthStore()
    
    @Published var stepsCount: Double = 0
    @Published var burnedCalories: Double = 0
    @Published var lastResetDate: String = ""
    
    // Функция для запроса разрешений
    func requestHealthKitPermissions() {
        // Шаги
        guard let steps = HKQuantityType.quantityType(forIdentifier: .stepCount),
              let calories = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else {
            print("Ошибка: не удалось получить типы данных")
            return
        }
        
        // Запрашиваем разрешения
        let dataTypes: Set<HKQuantityType> = [steps, calories]
        
        healthStore.requestAuthorization(toShare: [], read: dataTypes) { (success, error) in
            if success {
                print("Разрешение на доступ к данным получено")
            } else {
                print("Ошибка при запросе разрешений: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    // Функция для получения шагов
    func fetchStepsData() {
        guard let steps = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            print("Ошибка: не удалось найти тип данных для шагов")
            return
        }
        
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: Date()) // начало дня
        let endDate = Date() // текущий момент времени
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, result, error) in
            guard let result = result, let totalSteps = result.sumQuantity() else {
                print("Ошибка при получении данных о шагах: \(String(describing: error))")
                return
            }
            
            // Обновляем данные на главном потоке
            DispatchQueue.main.async {
                self.stepsCount = totalSteps.doubleValue(for: HKUnit.count())
                print("Шаги за сегодня: \(self.stepsCount)")
            }
        }
        
        // Выполняем запрос
        healthStore.execute(query)
    }
    
    func fetchCaloriesBurnedData() {
        guard let calories = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else {
            print("Ошибка: не удалось найти тип данных о калориях")
            return
        }
        
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: Date()) // начало дня
        let endDate = Date() // текущий момент времени
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, result, error) in
            guard let result = result, let totalCalories = result.sumQuantity() else {
                print("Ошибка при получении данных о калориях: \(String(describing: error))")
                return
            }
            
            // Обновляем данные на главном потоке
            DispatchQueue.main.async {
                self.burnedCalories = totalCalories.doubleValue(for: HKUnit.kilocalorie())
                print("Сожженные калории за сегодня: \(self.burnedCalories)")
            }
        }
        
        // Выполняем запрос
        healthStore.execute(query)
    }
    
    func resetDailyDataIfNeeded() {
        let today = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
        if today != lastResetDate {
            // Сбрасываем данные
            self.stepsCount = 0
            self.burnedCalories = 0
            lastResetDate = today
            print("Данные сброшены")
        }
    }
}
