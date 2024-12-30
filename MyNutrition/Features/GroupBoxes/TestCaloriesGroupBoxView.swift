//
//  CaloriesGroupBoxView.swift
//  MyNutrition
//
//  Created by Daniil on 30/12/2024.
//

import SwiftUI

struct TestCaloriesGroupBoxView: View {
    @EnvironmentObject var nutritionService: NutritionService
    var body: some View {
        GroupBox("") {
            VStack {
                if let data = nutritionService.nutritionData {
                    // title and question Button
                    HStack {
                        Text("Calories")
                            .font(.title2)
                        Spacer()
                        Image(systemName: "questionmark.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                    }
                    HStack {
                        // Chart
                        ZStack {
                            Circle()
                                .fill(.backGround)
                                .frame(width: 230, height: 230)
                            Circle()
                                .fill(.background)
                                .frame(width: 200, height: 200)
                            VStack(alignment: .center) {
                                Text("\(data.current.caloriesConsumed)")
                                    .font(.title.bold())
                                Text("Remaining")
                                    .font(.footnote)
                            }
                        }
                        .padding()
                        // Metrics
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "flag.fill")
                                    .font(.headline)
                                    .foregroundStyle(.text)
                                    .frame(width: 40, height: 40)
                                VStack(alignment: .leading) {
                                    Text("Calories Goal")
                                        .font(.headline)
                                        .foregroundStyle(.text)
                                    Text("2,400")
                                        .font(.title3.bold())
                                        .foregroundStyle(.text)
                                }
                            }
                            HStack {
                                Image(systemName: "flame.fill")
                                    .font(.headline)
                                    .foregroundStyle(.orange.gradient)
                                    .frame(width: 50, height: 50)
                                VStack(alignment: .leading) {
                                    Text("Day Strike")
                                        .font(.headline)
                                        .foregroundStyle(.text)
                                    Text("2 days")
                                        .font(.title3.bold())
                                        .foregroundStyle(.text)
                                }
                            }
                            HStack {
                                Image(systemName: "shoe.2.fill")
                                    .font(.headline)
                                    .foregroundStyle(.blue.gradient)
                                    .frame(width: 50, height: 50)
                                VStack(alignment: .leading) {
                                    Text("Steps")
                                        .font(.headline)
                                        .foregroundStyle(.text)
                                    Text("2,686")
                                        .font(.title3.bold())
                                        .foregroundStyle(.text)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
                    .padding()
            
            }
        .frame(width: 550, height: 300)
        
    }
}

