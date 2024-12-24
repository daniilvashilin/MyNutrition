//
//  MyNutritionApp.swift
//  MyNutrition
//
//  Created by Daniil on 17/12/2024.
//

import SwiftUI
import Firebase

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
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if baseAuthViewModel.isLoading {
                    LoadingScreenView()
                } else if baseAuthViewModel.isAuthenticated {
                    TestHomePageView(viewModel: baseAuthViewModel)
                } else {
                    FinalLoginScreenView()
                        .environmentObject(appState) // Передача состояния в приложение
                }
            }
        }
    }
}
