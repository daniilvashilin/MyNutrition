//
//  BaseAuthViewModel.swift
//  MyNutrition
//
//  Created by Daniil on 17/12/2024.
//

import Foundation
import FirebaseAuth
import FirebaseCore

@MainActor
class BaseAuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var isAuthenticated: Bool = false
    @Published var successMessage: String?
    
    enum errorHandle: LocalizedError {
        case invalidEmailOrPassword
        case emailAlreadyInUse
        case invalidEmail
        case invalidPassword
        case weakPassword
        case unexpectedError
        var errorDescription: String? {
            switch self {
            case .invalidEmailOrPassword: return "Invalid email or password"
            case .invalidEmail: return "Invalid email"
            case .invalidPassword: return "Invalid password"
            case .weakPassword: return "Weak password"
            case .unexpectedError: return "Fatal error occurred"
            case .emailAlreadyInUse: return "This email is already in use. Please try another."
            }
        }
    }
    
    enum AuthSuccess {
        case login
        case registration
        case logout

        var message: String {
            switch self {
            case .login: return "Successfully logged in."
            case .registration: return "Account successfully created."
            case .logout: return "Successfully logged out."
            }
        }
    }
    private func handleFirebaseError(_ error: NSError) -> String {
        switch error.code {
        case AuthErrorCode.invalidEmail.rawValue:
            return errorHandle.invalidEmail.errorDescription ?? "Invalid email"
        case AuthErrorCode.weakPassword.rawValue:
            return errorHandle.weakPassword.errorDescription ?? "Weak password"
        case AuthErrorCode.wrongPassword.rawValue:
            return errorHandle.invalidPassword.errorDescription ?? "Invalid password"
        case AuthErrorCode.emailAlreadyInUse.rawValue:
            return errorHandle.emailAlreadyInUse.errorDescription ?? "Email already in use"
        default:
            assertionFailure("Unhandled Firebase error: \(error.code)")
            return errorHandle.unexpectedError.errorDescription ?? "Unexpected error"
        }
    }
    
    private func logSuccess(_ message: String) {
        print("✅ \(message)")
    }
    
    private let authService = AuthService()
    
    func registerWithEmail() async throws {
        isLoading = true
        errorMessage = nil
        
        defer {
               isLoading = false  // Этот код гарантированно выполнится в конце
           }
        do {
            let user = try await authService.createUserWithEmail(email: email, password: password)
            isAuthenticated = true
            logSuccess("user: \(String(describing: user.email)) has been created with ID: \(user.uid)")
            successMessage = AuthSuccess.registration.message
        } catch let error as NSError {
            errorMessage = handleFirebaseError(error)
            throw error
        }
    }
    
    func signInWithEmail() async throws {
        isLoading = true
        errorMessage = nil
        
        defer {
               isLoading = false  // Этот код гарантированно выполнится в конце
           }
        do {
            let user = try await authService.signInWithEmail(email: email, password: password)
            isAuthenticated = true
            print("user: \(String(describing: user.email)) has loged in with ID: \(user.uid)")
            logSuccess("user: \(String(describing: user.email)) has been created with ID: \(user.uid)")
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
            successMessage = AuthSuccess.logout.message
        } catch let error as NSError {
            errorMessage = handleFirebaseError(error)
        }
    }
    
}
