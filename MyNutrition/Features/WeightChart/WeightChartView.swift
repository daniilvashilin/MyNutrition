//
//  WeightChartView.swift
//  MyNutrition
//
//  Created by Daniil on 15/01/2025.
//

import SwiftUI
import Charts

struct WeightChartView: View {
    @EnvironmentObject var nutritionService: NutritionService
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        GroupBox {
            VStack {
                HStack {
                    Text("Weight")
                        .font(.headline)
                    Spacer()
                }
                .padding(.horizontal)
                Chart {
                    if let data = nutritionService.nutritionData {
                        ForEach(data.weightHistory) { entry in
                            LineMark(
                                x: .value("Date", entry.date),
                                y: .value("Weight", entry.weight)
                            )
                        }
                        RuleMark(
                            y: .value("Target Weight", data.currentWeight)
                        )
                        .foregroundStyle(.red)
                    }
                }
                .padding()
            }
        }
        .frame(width: width, height: height)
        .clipped()
        .background(Color(.systemGray6))
        .groupBoxStyle(.plain)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}


