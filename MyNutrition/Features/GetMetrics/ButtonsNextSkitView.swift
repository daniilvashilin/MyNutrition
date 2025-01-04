//
//  ButtonsNextSkitView.swift
//  MyNutrition
//
//  Created by Daniil on 04/01/2025.
//

import SwiftUI

struct ButtonsNextSkitView: View {
    var widthButton: CGFloat
    var heightButton: CGFloat
    var fontSize: CGFloat
    @Binding var  skipAccess: Bool
    @State var skipDestination: AnyView? = nil
    @State var nextDestination: AnyView? = nil
    @Binding var disabled: Bool
    
    var body: some View {
        HStack {
            NavigationLink(destination: skipDestination) {
                Text("Skip")
                    .foregroundStyle(.primary)
                    .font(.custom("FontSize", fixedSize: fontSize))
            }
            .disabled(skipAccess) // Disable if destination is not set
            .getCustomButtonStyle(width: widthButton, height: heightButton)
            .padding(.horizontal)
            
            Spacer()
            
            NavigationLink(destination: nextDestination) {
                Text("Next")
                    .foregroundStyle(.primary)
                    .font(.custom("FontSize", fixedSize: fontSize))
            }
            .disabled(disabled) // Disable if destination is not set
            .getCustomButtonStyle(width: widthButton, height: heightButton)
            .padding(.horizontal)
        }
    }
}


