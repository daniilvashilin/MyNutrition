//
//  HeaderView.swift
//  MyNutrition
//
//  Created by Daniil on 15/01/2025.
//

import SwiftUI

struct HeaderView: View {
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle.fill")
                .font(.title3)
            Spacer()
            Text("MyNutrition")
                .font(.title2)
            Spacer()
            Image(systemName: "star.fill")
                .font(.title3)
                .foregroundStyle(.yellow)
        }
        .padding()
        .frame(width: width, height: height)
    }
}

#Preview {
    HeaderView(width: 400, height: 80)
}
