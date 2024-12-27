//
//  TestHomePageView.swift
//  MyNutrition
//
//  Created by Daniil on 23/12/2024.
//

import SwiftUI
import FirebaseAuth

struct TestHomePageView: View {
    @ObservedObject var viewModel: BaseAuthViewModel
    @ObservedObject var authservice: AuthService
    var body: some View {
        Text("Home page view test!")
        Button {
            Task {
                do {
                    await viewModel.logout()
                }
            }
            
        } label: {
            Text("Sign Out")
        }
        
        Button {
            Task {
                do {
                    guard let currentUser = Auth.auth().currentUser else {
                        print("Пользователь не авторизован")
                        return
                    }
                    // Удаляем связанные данные
                    try await AuthService.shared.deleteRelatedData(for: currentUser.uid)
                    
                    // Удаляем аккаунт
                    await AuthService.shared.deleteUserAccount()
                    
                    print("Аккаунт и связанные данные успешно удалены")
                } catch {
                    print("Ошибка при удалении аккаунта: \(error.localizedDescription)")
                }
            }
        } label: {
            Text("Delete account")
        }
        
        
    }
}

