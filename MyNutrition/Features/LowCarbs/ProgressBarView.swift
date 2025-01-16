//
//  ProgressBarView.swift
//  MyNutrition
//
//  Created by Daniil on 12/01/2025.
//

import SwiftUI

struct ProgressBarView: View {
    var value: Double
    var maxValue: Double
    var barColor: Color
    var backgroundColor: Color
    var width: CGFloat
    var height: CGFloat
    var titleForProgress: String
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(titleForProgress)
                    .font(.footnote)
                Spacer()
                Text("\(value, format: .number.grouping(.automatic).precision(.fractionLength(0)))/\(maxValue, format: .number.grouping(.automatic).precision(.fractionLength(0)))")
                    .font(.footnote)
            }
            .padding(.horizontal)
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: width * 0.03)
                    .fill(backgroundColor)
                    .frame(height: height * 0.03)
                if value > 0 {
                    RoundedRectangle(cornerRadius: width * 0.03)
                        .fill(barColor)
                        .frame(width: calculateWidth(), height: height * 0.03)
                    
                }
            }
        }
        .padding()
    }
    private func calculateWidth() -> CGFloat {
        let screnWidth = UIScreen.main.bounds.width - 40
        return (value / maxValue) * screnWidth
    }
}

#Preview {
    ProgressBarView(value: 50, maxValue: 250, barColor: .orange, backgroundColor: .secondary, width: 350, height: 500, titleForProgress: "Fats")
}



