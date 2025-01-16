//
//  LowCarbsIPhoneView.swift
//  MyNutrition
//
//  Created by Daniil on 12/01/2025.
//

import SwiftUI

struct LowCarbsIPhoneView: View {
    @EnvironmentObject var nutritionService: NutritionService
    @EnvironmentObject var healthKitManager: HealthKitManager
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        
        GroupBox {
            VStack(spacing: 0) {
                HStack {
                    Text("Low Carb")
                        .font(.headline)
                    Spacer()
                }
                .padding(.horizontal)
                
                if let data = nutritionService.nutritionData {
                    ProgressBarView(value: data.current.carbsConsumed, maxValue: data.carbsGoal, barColor: .orange, backgroundColor: .secondary.opacity(0.3), width: width, height: height, titleForProgress: "Carbohydrates")
                    ProgressBarView(value: data.current.sugarConsumed, maxValue: data.sugarGoal, barColor: .indigo, backgroundColor: .secondary.opacity(0.3), width: width, height: height, titleForProgress: "Sugar")
                    ProgressBarView(value: data.current.fiberConsumed, maxValue: data.fiberGoal, barColor: .purple, backgroundColor: .secondary.opacity(0.3), width: width, height: height, titleForProgress: "Fiber")
                }
            }
            .padding(.vertical)
        }
        .frame(width: width, height: height)
        .clipped()
        .background(Color(.systemGray6))
        .groupBoxStyle(.plain)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    LowCarbsIPhoneView(width: 400 , height: 250)
}
