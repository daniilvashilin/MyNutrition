//
//  ProtCrabsFatMetricsView.swift
//  MyNutrition
//
//  Created by Daniil on 31/12/2024.
//

import SwiftUI

struct ProtCarbsFatMetricsView: View {
    @EnvironmentObject var nutritionService: NutritionService
    @Environment(\.horizontalSizeClass) var sizeClass
    var height: CGFloat
    var width: CGFloat
    var corner: CGFloat
    var body: some View {
        if sizeClass == .compact {
            GroupBox {
                HStack {
                    if let data = nutritionService.nutritionData {
                        // Prot
                        CircleChartView(backgroundColorCircle: .backGround, secondBackgroundColorCircle: .orange, goal: <#T##Double#>, current: <#T##Double#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>, subLabel: <#T##String#>, resultValue: <#T##Double#>, lineWidth: <#T##CGFloat#>, resultFont: <#T##CGFloat#>)
                        // Fat
                        CircleChartView(backgroundColorCircle: <#T##Color#>, secondBackgroundColorCircle: <#T##Color#>, goal: <#T##Double#>, current: <#T##Double#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>, subLabel: <#T##String#>, resultValue: <#T##Double#>, lineWidth: <#T##CGFloat#>, resultFont: <#T##CGFloat#>)
                        // Carbs
                        CircleChartView(backgroundColorCircle: <#T##Color#>, secondBackgroundColorCircle: <#T##Color#>, goal: <#T##Double#>, current: <#T##Double#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>, subLabel: <#T##String#>, resultValue: <#T##Double#>, lineWidth: <#T##CGFloat#>, resultFont: <#T##CGFloat#>)
                    }
                }
            }
            frame(width: width, height: height, alignment: .center)
                .background(.textField)
                .groupBoxStyle(.plain)
                .clipShape(RoundedRectangle(cornerRadius: corner))
        } else if sizeClass == .regular {
            VStack {
                
            }
        }
    }
}
