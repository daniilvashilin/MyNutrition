//
//  IPhoneMacrosBoardView.swift
//  MyNutrition
//
//  Created by Daniil on 02/01/2025.
//

import SwiftUI

struct IPhoneMacrosBoardView: View {
    @EnvironmentObject var healthKitManager: NutritionService
    @EnvironmentObject var nutritionService: NutritionService
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        GroupBox {
            HStack(spacing: 0) {
                if let data = nutritionService.nutritionData {
                    CustomMacrosCompanents(underNmae: "Protein", goal: Double(data.proteinGoal), strokeColor: .yellow, gradientColor: .orange, current: Double(data.current.proteinConsumed), lineWidth: width * 0.02, circleWidth: width * 0.40, circleHeight: height * 0.55, result: Double(data.proteinGoal - data.current.proteinConsumed), width: width)
                        .frame(width: width * 0.3)
                        CustomMacrosCompanents(underNmae: "Fat", goal: Double(data.fatGoal), strokeColor: .yellow, gradientColor: .orange, current: Double(data.current.fatConsumed), lineWidth: width * 0.02, circleWidth: width * 0.40, circleHeight: height * 0.55, result: Double(data.proteinGoal - data.current.proteinConsumed), width: width)
                            .frame(width: width * 0.3)
                    CustomMacrosCompanents(underNmae: "Carbs", goal: Double(data.carbsGoal), strokeColor: .yellow, gradientColor: .orange, current: Double(data.current.carbsConsumed), lineWidth: width * 0.02, circleWidth: width * 0.40, circleHeight: height * 0.55, result: Double(data.proteinGoal - data.current.proteinConsumed), width: width)
                        .frame(width: width * 0.3)
                }
            }
        }
        .frame(width: width, height: height) // Устанавливаем фиксированный размер
        .clipped() // Ограничиваем содержимое внутри рамки
        .background(Color(.systemGray6))
        .groupBoxStyle(.plain)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}


struct CustomMacrosCompanents: View {
    let underNmae: String
    var goal: Double
    var strokeColor: Color
    var gradientColor: Color
    var current: Double
    var lineWidth: CGFloat
    var circleWidth: CGFloat
    var circleHeight: CGFloat
    var result: Double
    var width: CGFloat
    
    var body: some View {
        VStack(spacing: width * 0.04){
            IPhoneCustomCircleChartView(goal: goal, strokeColor: strokeColor, gradientColor: gradientColor, current: current, lineWidth: lineWidth, circleWidth: circleWidth, circleHeight: circleHeight, result: result)
            Text(underNmae)
                .font(.custom("", fixedSize: width * 0.03))
                .foregroundStyle(.text)
        }
    }
}
