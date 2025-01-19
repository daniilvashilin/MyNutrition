//
//  AddPageSheetView.swift
//  MyNutrition
//
//  Created by Daniil on 19/01/2025.
//

import SwiftUI

struct AddPageSheetView: View {
    @Binding var selectItemToAddPage: AddPageSelection
    @Binding var showAddPage: Bool
    
    var body: some View {
        HStack(spacing: 15) {
            AddButton(icon: "list.bullet.rectangle.portrait.fill", text: "My products", color: .green) {
                selectItemToAddPage = .searchUserItems
                showAddPage = false
            }
            AddButton(icon: "magnifyingglass.circle.fill", text: "Search new products", color: .blue) {
                selectItemToAddPage = .searchNew
                showAddPage = false
            }
        }
        .padding()
    }
}
enum AddPageSelection {
    case home
    case searchNew
    case searchUserItems
}
// Вспомогательное представление для кнопки
struct AddButton: View {
    let icon: String
    let text: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.headline)
                .foregroundStyle(.white)
            Button(action: action) {
                Text(text)
                    .font(.footnote)
                    .foregroundStyle(.white)
            }
        }
        .padding()
        .background(color)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}
