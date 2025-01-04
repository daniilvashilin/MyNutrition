//
//  BaseAuthViewModel.swift
//  MyNutrition
//
//  Created by Daniil on 17/12/2024.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

@MainActor
class BaseAuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    @Published var passwordConfirmation: String = ""
    @Published var isLoading: Bool = false
    @Published var isAuthenticated: Bool = false
    @Published var successMessage: String?
    @Published var isFirstLogin: Bool = true
    private var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    
    private static let allowedDomains = [
        "gmail.com", "icloud.com", "yahoo.com",
        "outlook.com", "hotmail.com", "live.com",
        "yandex.ru", "yandex.com", "mail.ru", "protonmail.com"
    ]
    
    init() {
        startAuthListener()
    }
    
    private func startAuthListener() {
        authStateListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                guard let self = self else { return }
                let wasAuthenticated = self.isAuthenticated
                self.isAuthenticated = (user != nil)
                if wasAuthenticated != self.isAuthenticated {
                    print("Listener: Authentication state changed: \(self.isAuthenticated)")
                }
                self.isLoading = false
            }
        }
    }
    
    deinit {
        if let handle = authStateListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
            print("Listener removed in deinit")
        }
    }
    
    // Переписал код, убрав try внутри выражения
    func checkIfFirstLogin() async {
        guard let user = Auth.auth().currentUser else { return }
        
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(user.uid)
        
        do {
            let document = try await docRef.getDocument()
            if let data = document.data() {
                self.isFirstLogin = data["isFirstLogin"] as? Bool ?? true
                if self.isFirstLogin {
                    await self.markFirstLoginCompleted()
                }
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func markFirstLoginCompleted() async {
        guard let user = Auth.auth().currentUser else { return }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user.uid)
        
        do {
            // Получаем данные пользователя
            let document = try await userRef.getDocument()
            if var data = document.data() {
                let isFirstLogin = data["isFirstLogin"] as? Bool ?? true
                if isFirstLogin {
                    // Обновляем данные пользователя, если это его первый вход
                    data["isFirstLogin"] = false
                    // Обновляем только нужное поле
                    try await userRef.setData(data, merge: true)
                }
            }
        } catch {
            print("Error in updating first login: \(error)")
        }
    }
    
    func stopAuthListener() {
        if let handle = authStateListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
            print("Listener removed manually")
            authStateListenerHandle = nil
        }
    }
    
    enum UnvalidEmailHandel: LocalizedError {
        case missingAtSymbol
        case missingDotSymbol
        case notValidDomain
        
        var unvalidEmailHandelDescription: String {
            switch self {
            case .missingAtSymbol:
                return "Missing @ symbol"
            case .missingDotSymbol:
                return "Missing . symbol"
            case .notValidDomain:
                return "Use valid domain like 'gmail.com' and more..."
            }
        }
    }
    
    func validateEmail(_ email: String) throws {
        guard email.contains("@") else {
            throw UnvalidEmailHandel.missingAtSymbol
        }
        
        let components = email.split(separator: "@")
        guard components.count == 2 else {
            throw UnvalidEmailHandel.missingAtSymbol
        }
        
        let domainPart = components[1]
        guard domainPart.contains(".") else {
            throw UnvalidEmailHandel.missingDotSymbol
        }
        
        guard Self.allowedDomains.contains(String(domainPart)) else {
            throw UnvalidEmailHandel.notValidDomain
        }
    }
    
    enum FirebaseError: LocalizedError {
        case invalidEmailOrPassword
        case emailAlreadyInUse
        case invalidEmail
        case invalidPassword
        case weakPassword
        case userMismatch
        case unexpectedError
        
        var errorDescription: String? {
            switch self {
            case .invalidEmailOrPassword: return "Invalid email or password."
            case .invalidEmail: return "Invalid email."
            case .invalidPassword: return "Invalid password."
            case .weakPassword: return "Password is too weak."
            case .emailAlreadyInUse: return "This email is already in use. Please try another."
            case .userMismatch: return "Email and password do not match."
            case .unexpectedError: return "An unexpected error occurred."
            }
        }
    }
    
    private func handleFirebaseError(_ error: NSError) -> String {
        switch error.code {
        case AuthErrorCode.invalidEmail.rawValue:
            return FirebaseError.invalidEmail.errorDescription ?? "Invalid email."
        case AuthErrorCode.weakPassword.rawValue:
            return FirebaseError.weakPassword.errorDescription ?? "Weak password."
        case AuthErrorCode.wrongPassword.rawValue:
            return FirebaseError.invalidPassword.errorDescription ?? "Invalid password."
        case AuthErrorCode.emailAlreadyInUse.rawValue:
            return FirebaseError.emailAlreadyInUse.errorDescription ?? "Email already in use."
        case AuthErrorCode.userMismatch.rawValue:
            return FirebaseError.userMismatch.errorDescription ?? "User mismatch."
        default:
            print("Unhandled Firebase error: \(error.code)")
            return FirebaseError.unexpectedError.errorDescription ?? "Unexpected error."
        }
    }
    
    private func logSuccess(_ message: String) {
        print("✅ \(message)")
    }
    
    private let authService = AuthService()
    
    func registerWithEmail() async throws {
        isLoading = true
        errorMessage = nil
        
        defer { isLoading = false }
        
        do {
            try validateEmail(email)
            let user = try await authService.createUserWithEmail(email: email, password: password)
            isAuthenticated = true
            logSuccess("User \(user.email ?? "") has been created with ID: \(user.uid).")
            successMessage = "Account successfully created."
        } catch let error as UnvalidEmailHandel {
            errorMessage = error.errorDescription
            throw error
        } catch let error as NSError {
            errorMessage = handleFirebaseError(error)
            throw error
        }
    }
    
    func signInWithEmail() async throws {
        isLoading = true
        errorMessage = nil
        
        defer { isLoading = false }
        
        do {
            try validateEmail(email)
            let user = try await authService.signInWithEmail(email: email, password: password)
            logSuccess("User \(user.email ?? "") has logged in with ID: \(user.uid).")
        } catch let error as UnvalidEmailHandel {
            errorMessage = error.errorDescription
            throw error
        } catch let error as NSError {
            errorMessage = handleFirebaseError(error)
            throw error
        }
    }
    
    func logout() async {
        do {
            try authService.signOut()
            isAuthenticated = false
            email = ""
            password = ""
            successMessage = "Successfully logged out."
        } catch let error as NSError {
            errorMessage = handleFirebaseError(error)
        }
    }
}
