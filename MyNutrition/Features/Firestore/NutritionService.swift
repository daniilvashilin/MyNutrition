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
        
        guard let data = document.data() else {
            throw NSError(domain: "FirestoreError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Document not found"])
        }
        
        let currentData = data["current"] as? [String: Int] ?? [:]
        let historyData = data["history"] as? [[String: Any]] ?? []
        
        let nutrition = Nutrition(
            id: userID,
            caloriesGoal: data["caloriesGoal"] as? Int ?? 0,
            proteinGoal: data["proteinGoal"] as? Int ?? 0,
            fatGoal: data["fatGoal"] as? Int ?? 0,
            carbsGoal: data["carbsGoal"] as? Int ?? 0,
            sugarGoal: data["sugarGoal"] as? Int ?? 0,
            fiberGoal: data["fiberGoal"] as? Int ?? 0,
            weightGoal: data["weightGoal"] as? Int ?? 0,
            current: Nutrition.CurrentNutrition(
                caloriesConsumed: currentData["caloriesConsumed"] ?? 0,
                proteinConsumed: currentData["proteinConsumed"] ?? 0,
                fatConsumed: currentData["fatConsumed"] ?? 0,
                carbsConsumed: currentData["carbsConsumed"] ?? 0,
                sugarConsumed: currentData["sugarConsumed"] ?? 0,
                fiberConsumed: currentData["fiberConsumed"] ?? 0,
                move: currentData["move"] ?? 0,
                exerciseMinutes: currentData["exerciseMinutes"] ?? 0,
                steps: currentData["steps"] ?? 0
            ),
            history: historyData.compactMap { entry in
                guard let dateString = entry["date"] as? String,
                      let date = DateFormatter().date(from: dateString) else { return nil }
                return Nutrition.DailyNutrition(
                    date: date,
                    caloriesConsumed: entry["caloriesConsumed"] as? Int ?? 0,
                    proteinConsumed: entry["proteinConsumed"] as? Int ?? 0,
                    fatConsumed: entry["fatConsumed"] as? Int ?? 0,
                    carbsConsumed: entry["carbsConsumed"] as? Int ?? 0,
                    sugarConsumed: entry["sugarConsumed"] as? Int ?? 0,
                    fiberConsumed: entry["fiberConsumed"] as? Int ?? 0,
                    move: entry["move"] as? Int ?? 0,
                    exerciseMinutes: entry["exerciseMinutes"] as? Int ?? 0,
                    steps: entry["steps"] as? Int ?? 0
                )
            },
            lastResetDate: Date()
        )
        DispatchQueue.main.async {
            self.nutritionData = nutrition
        }
    }
}
