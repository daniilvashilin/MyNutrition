import Foundation
import FirebaseFirestore
import FirebaseAuth

final class NutritionService: ObservableObject {
    static let shared = NutritionService()
    private let db = Firestore.firestore()
    
    @Published var nutritionData: Nutrition?
    private var authListener: AuthStateDidChangeListenerHandle?
    
    init() {
        observeAuthState()
    }
    
    private func observeAuthState() {
        authListener = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            if let user = user {
                Task {
                    do {
                        try await self.fetchNutritionData(for: user.uid)
                    } catch {
                        print("Ошибка загрузки данных: \(error.localizedDescription)")
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.nutritionData = nil
                }
            }
        }
    }
    
    deinit {
        if let authListener = authListener {
            Auth.auth().removeStateDidChangeListener(authListener)
        }
    }
    
    func fetchNutritionData(for userID: String) async throws {
        let document = try await db.collection("nutrition").document(userID).getDocument()
        let userID = userID ?? (Auth.auth().currentUser?.uid)
           
           guard let userID = userID else {
               throw NSError(domain: "NutritionService", code: -1, userInfo: [NSLocalizedDescriptionKey: "User ID not found"])
           }
        
        guard let data = document.data() else {
            throw NSError(domain: "FirestoreError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Document not found"])
        }
        
        let currentData = data["current"] as? [String: Int] ?? [:]
        let historyData = data["history"] as? [[String: Any]] ?? []
        let weightHistoryData = data["weightHistory"] as? [[String: Any]] ?? [] // История веса
        
        let nutrition = Nutrition(
            id: userID,
            caloriesGoal: data["caloriesGoal"] as? Double ?? 0,
            proteinGoal: data["proteinGoal"] as? Double ?? 0,
            fatGoal: data["fatGoal"] as? Double ?? 0,
            carbsGoal: data["carbsGoal"] as? Double ?? 0,
            sugarGoal: data["sugarGoal"] as? Double ?? 0,
            fiberGoal: data["fiberGoal"] as? Double ?? 0,
            goalWeight: data["goalWeight"] as? Double ?? 0, // Целевой вес
            currentWeight: data["currentWeight"] as? Double ?? 0, // Текущий вес
            weightHistory: weightHistoryData.compactMap { entry in
                guard let date = (entry["date"] as? Timestamp)?.dateValue(),
                      let weight = entry["weight"] as? Double else {
                    return nil
                }
                return Nutrition.WeightEntry(date: date, weight: weight)
            },
            current: Nutrition.CurrentNutrition(
                caloriesConsumed: Double(currentData["caloriesConsumed"] ?? 0),
                proteinConsumed: Double(currentData["proteinConsumed"] ?? 0),
                fatConsumed: Double(currentData["fatConsumed"] ?? 0),
                carbsConsumed: Double(currentData["carbsConsumed"] ?? 0),
                sugarConsumed: Double(currentData["sugarConsumed"] ?? 0),
                fiberConsumed: Double(currentData["fiberConsumed"] ?? 0),
                move: Double(currentData["move"] ?? 0),
                exerciseMinutes: Double(currentData["exerciseMinutes"] ?? 0),
                steps: Double(currentData["steps"] ?? 0)
            ),
            history: historyData.compactMap { entry in
                guard let dateString = entry["date"] as? String,
                      let date = DateFormatter().date(from: dateString) else {
                    return nil
                }
                return Nutrition.DailyNutrition(
                    date: date,
                    caloriesConsumed: entry["caloriesConsumed"] as? Double ?? 0,
                    proteinConsumed: entry["proteinConsumed"] as? Double ?? 0,
                    fatConsumed: entry["fatConsumed"] as? Double ?? 0,
                    carbsConsumed: entry["carbsConsumed"] as? Double ?? 0,
                    sugarConsumed: entry["sugarConsumed"] as? Double ?? 0,
                    fiberConsumed: entry["fiberConsumed"] as? Double ?? 0,
                    move: entry["move"] as? Double ?? 0,
                    exerciseMinutes: entry["exerciseMinutes"] as? Double ?? 0,
                    steps: entry["steps"] as? Double ?? 0
                )
            },
            lastResetDate: (data["lastResetDate"] as? Timestamp)?.dateValue() ?? Date()
        )
        
        DispatchQueue.main.async {
            self.nutritionData = nutrition
        }
    }
}
