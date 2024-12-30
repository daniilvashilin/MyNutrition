//
//  CaloriesGroupBoxView.swift
//  MyNutrition
//
//  Created by Daniil on 30/12/2024.
//

import SwiftUI

struct CaloriesGroupBoxView: View {
    @EnvironmentObject var nutritionService: NutritionService
    var height: CGFloat
    var width: CGFloat
    var corner: CGFloat
    var body: some View {
        GroupBox("Calories") {
            HStack {
                if let data = nutritionService.nutritionData {
                    CircleChartView(backgroundColorCircle: .backGround, secondBackgroundColorCircle: .circleGreen, goal: Double(data.caloriesGoal), current: Double(data.current.caloriesConsumed), width: width * 0.6, height: height * 0.6, subLabel: "Remaining", resultValue: Double(data.caloriesGoal - data.current.caloriesConsumed), lineWidth: width * 0.03, resultFont: width * 0.1)
                    VStack(alignment: .leading) {
                        MainMetricsView(goal: Double(data.caloriesGoal), image: "flag.fill", title: "Calories Goal", imageWidth: width, imageHeight: height, imageColor: .text, format: "cal")
                        MainMetricsView(goal: Double(2), image: "flame.fill", title: "Day Strike", imageWidth: width, imageHeight: height, imageColor: .orange, format: "days")
                        MainMetricsView(goal: Double(2200), image: "shoe.2.fill", title: "Steps", imageWidth: width, imageHeight: height, imageColor: .blue, format: "steps")
                     
                    }
                }
            }
        }
        .frame(width: width, height: height, alignment: .center)
        .background(.textField)
        .groupBoxStyle(.plain)
        .clipShape(RoundedRectangle(cornerRadius: corner))
    }
}


struct MainMetricsView: View {
    var goal: Double
    var image: String
    var title: String
    var imageWidth: CGFloat
    var imageHeight: CGFloat
    var imageColor: Color
    var format: String
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: image)
                .frame(width: imageWidth * 0.001, height: imageHeight * 0.001)
                .font(.caption2)
                .foregroundStyle(imageColor.gradient)
                .padding(.trailing)
            VStack {
              Text("\(title)")
                    .font(.caption2)
                Text("\(goal, format: .number.grouping(.automatic).precision(.fractionLength(0))) \(format)")
                    .font(.caption.bold())
            }
        }
        .frame(width: imageWidth * 0.3, height: imageHeight * 0.1, alignment: .leading)
        .padding(.vertical)
    }
}
