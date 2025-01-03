//
//  TipKitVIew.swift
//  MyNutrition
//
//  Created by Daniil on 03/01/2025.
//

import SwiftUI
import TipKit

struct TipKitVIew: View {
    @Binding var isVisible: Bool
    var message: String
    
    var body: some View {
        if isVisible {
            VStack {
                Spacer()
                HStack {
                    Text(message)
                        .font(.body)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .shadow(radius: 10)
                        .padding(.bottom, 10)
                    Spacer()
                }
            }
            .transition(.move(edge: .bottom))
            .animation(.spring(), value: isVisible)
        }
    }
}
