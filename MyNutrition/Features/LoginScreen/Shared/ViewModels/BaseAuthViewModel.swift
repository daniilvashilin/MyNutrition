//
//  BaseAuthViewModel.swift
//  MyNutrition
//
//  Created by Daniil on 17/12/2024.
//

import Foundation

class BaseAuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    func login() {
        // Logic
    }
    
    func register() {
        // Logic
    }
}
