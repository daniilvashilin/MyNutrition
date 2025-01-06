import SwiftUI
import Firebase
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

class AppState: ObservableObject {
    @Published var showRegisterScreen: Bool = false
}

@main
struct MyNutritionApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var baseAuthViewModel = BaseAuthViewModel()
    @StateObject private var appState = AppState()
    @StateObject private var authService = AuthService()
    @StateObject private var nutritionService = NutritionService()
    @StateObject private var healthKitManager = HealthKitManager()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if baseAuthViewModel.isLoading {
                    LoadingScreenView()
                        .environmentObject(appState)
                        .environmentObject(nutritionService)
                        .environmentObject(authService)
                        .environmentObject(baseAuthViewModel)
                        .environmentObject(healthKitManager)
                } else if baseAuthViewModel.isAuthenticated {
                    FinalIphoneMainView()
                        .environmentObject(appState)
                        .environmentObject(nutritionService)
                        .environmentObject(authService)
                        .environmentObject(baseAuthViewModel)
                        .environmentObject(healthKitManager)
                } else {
                    FinalLoginScreenView()
                        .environmentObject(appState)
                        .environmentObject(nutritionService)
                        .environmentObject(authService)
                        .environmentObject(baseAuthViewModel)
                        .environmentObject(healthKitManager)
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                }
            }
            .onAppear {
                Task {
                    do {
                        if let user = Auth.auth().currentUser {
                            try await authService.resetDailyDataIfNeeded(uid: user.uid)
                            print("Сброс ежедневных данных завершён.")
                        }
                    } catch {
                        print("Ошибка при сбросе данных: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}
