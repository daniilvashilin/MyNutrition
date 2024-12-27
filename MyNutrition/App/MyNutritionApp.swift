//
//  MyNutritionApp.swift
//  MyNutrition
//
//  Created by Daniil on 17/12/2024.
//

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
    @StateObject private var appState = AppState() // Глобальное состояние приложения
    @StateObject private var authService = AuthService()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if baseAuthViewModel.isLoading {
                    LoadingScreenView()
                } else if baseAuthViewModel.isAuthenticated {
                    TestHomePageView(viewModel: baseAuthViewModel, authservice: authService)
                        .onAppear {
                            Task {
                                if let user = Auth.auth().currentUser {
                                    do {
                                        try await authService.resetDailyDataIfNeeded(uid: user.uid)
                                    } catch {
                                        print("Ошибка при сбросе данных: \(error.localizedDescription)")
                                    }
                                }
                            }
                        }
                } else {
                    FinalLoginScreenView(authService: authService)
                        .environmentObject(appState) // Передача состояния в приложение
                }
            }
        }
    }
}
