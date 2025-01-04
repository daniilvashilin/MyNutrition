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
    @StateObject private var themeManager = ThemeManager()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if baseAuthViewModel.isLoading {
                    LoadingScreenView()
                        .environmentObject(themeManager)
                } else if baseAuthViewModel.isFirstLogin {
                    WelcomePageView()
                        .environmentObject(nutritionService)
                        .environmentObject(authService)
                        .environmentObject(baseAuthViewModel)
                        .environmentObject(healthKitManager)
                        .environmentObject(themeManager)
                } else if baseAuthViewModel.isAuthenticated {
                    ReadyFinalMainScreenView()
                        .environmentObject(nutritionService)
                        .environmentObject(authService)
                        .environmentObject(baseAuthViewModel)
                        .environmentObject(healthKitManager)
                        .environmentObject(themeManager)
                } else {
                    FinalLoginScreenView()
                        .environmentObject(appState)
                        .environmentObject(nutritionService)
                        .environmentObject(authService)
                        .environmentObject(baseAuthViewModel)
                        .environmentObject(themeManager)
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                }
            }
            .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
            .onAppear {
                Task {
                    do {
                        if let user = Auth.auth().currentUser {
                            try await authService.resetDailyDataIfNeeded(uid: user.uid)
                            print("Сброс ежедневных данных завершён.")
                        }
                        await baseAuthViewModel.checkIfFirstLogin()
                    } catch {
                        print("Ошибка при сбросе данных: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}
