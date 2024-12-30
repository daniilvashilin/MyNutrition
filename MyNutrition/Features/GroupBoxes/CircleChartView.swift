//
//  CircleChartView.swift
//  MyNutrition
//
//  Created by Daniil on 30/12/2024.
//

import SwiftUI


struct CircleChartView: View {
    var backgroundColorCircle: Color
    var secondBackgroundColorCircle: Color
    var goal: CGFloat
    var current: CGFloat
    var width: CGFloat
    var height: CGFloat
    var subLabel: String
    var resultValue: CGFloat
    var lineWidth: CGFloat
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .opacity(0.2)
                .foregroundColor(backgroundColorCircle)
            Circle()
                .trim(from: 0.0, to: CGFloat(current / goal))
                .stroke(secondBackgroundColorCircle,
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut(duration: 1), value: current)
            
            VStack {
                Text("\(resultValue, format: .number.grouping(.automatic).precision(.fractionLength(0)))")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text(subLabel)
            }
        }
        .frame(width: width, height: height)
    }
}

