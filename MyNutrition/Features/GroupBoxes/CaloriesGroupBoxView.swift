//
//  CaloriesGroupBoxView.swift
//  MyNutrition
//
//  Created by Daniil on 30/12/2024.
//

import SwiftUI

struct CaloriesGroupBoxView: View {
    var height: CGFloat
    var width: CGFloat
    var corner: CGFloat
    var body: some View {
        GroupBox("Calories") {
            Text("1,800")
        }
        .frame(width: width, height: height)
        .background(.textField)
        .groupBoxStyle(.plain)
        .clipShape(RoundedRectangle(cornerRadius: corner))
    }
}

#Preview {
    CaloriesGroupBoxView(height: 300, width: 400, corner: 10)
}

