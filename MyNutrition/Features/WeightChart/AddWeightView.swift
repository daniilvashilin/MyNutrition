//
//  AddWeightView.swift
//  MyNutrition
//
//  Created by Daniil on 16/01/2025.
//

import SwiftUICore
import SwiftUI
import FirebaseAuth

struct AddWeightView: View {
    @EnvironmentObject var nutritionService: NutritionService
    @EnvironmentObject var authservice: AuthService
    @State private var weight: String = ""
    @Binding var closeTab: Bool
    var body: some View {
        VStack {
            TextField("Enter your weight", text: $weight)
                .keyboardType(.decimalPad)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            
            Button("Add Weight") {
                if let weightValue = Double(weight) {
                    Task {
                        do {
                            try await authservice.addWeightEntry(newWeight: weightValue)
                            print("Weight added successfully!")
                            if let userID = Auth.auth().currentUser?.uid {
                                try await nutritionService.fetchNutritionData(for: userID)
                            } else {
                                print("Error: User ID not found.")
                            }
                        } catch {
                            print("Error adding weight: \(error.localizedDescription)")
                        }
                    }
                } else {
                    print("Invalid weight entered")
                }
                closeTab = false
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
