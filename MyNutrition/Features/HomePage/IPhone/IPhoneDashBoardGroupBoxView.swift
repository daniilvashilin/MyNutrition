import SwiftUI
struct IPhoneDashBoardGroupBoxView: View {
    var width: CGFloat
    var height: CGFloat
    @EnvironmentObject var nutritionService: NutritionService
    @EnvironmentObject var healthKitManager: HealthKitManager
    @State private var showingTip = false
    var body: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: height * 0.13) {
                HStack {
                    Text("Calories")
                        .font(.headline)
                    Spacer()
                    Button {
                        showingTip.toggle() // Показываем/скрываем подсказку
                    } label: {
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(.gray)
                    }
                }
                
                HStack {
                    if let data = nutritionService.nutritionData {
                        // График
                        IPhoneCustomCircleChartView(
                            goal: Double(data.caloriesGoal),
                            strokeColor: .green,
                            gradientColor: .circleGreen,
                            current: Double(data.current.caloriesConsumed),
                            lineWidth: 8,
                            circleWidth: width * 0.4,
                            circleHeight: height * 0.6,
                            result: Double(data.caloriesGoal - data.current.caloriesConsumed)
                        )
                        .frame(maxWidth: width * 0.60, alignment: .leading)
                    }
                    VStack(alignment: .leading, spacing: height * 0.05) {
                        if let data = nutritionService.nutritionData {
                            // Используем NumberFormatter для отображения данных с нужным форматом
                            CustomMetricsComponent(
                                title: "Base Goal",
                                subtitle: NumberFormatter.calorieFormatter.string(from: NSNumber(value: data.caloriesGoal)) ?? "0",
                                image: "flag.fill",
                                width: width,
                                imageColor: .text,
                                metricType: "cal"
                            )
                            CustomMetricsComponent(
                                title: "Burned",
                                subtitle: NumberFormatter.calorieFormatter.string(from: NSNumber(value: healthKitManager.burnedCalories)) ?? "0",
                                image: "flame",
                                width: width,
                                imageColor: .orange,
                                metricType: "days"
                            )
                            CustomMetricsComponent(
                                title: "Steps",
                                subtitle: NumberFormatter.calorieFormatter.string(from: NSNumber(value: healthKitManager.stepsCount)) ?? "0",
                                image: "shoe.2",
                                width: width,
                                imageColor: .indigo,
                                metricType: "steps"
                            )
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: height * 0.02, alignment: .center)
                }
            }
            .padding()
        }
        .frame(width: width, height: height) // Устанавливаем фиксированный размер
        .clipped() // Ограничиваем содержимое внутри рамки
        .background(Color(.systemGray6))
        .groupBoxStyle(.plain)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}


struct CustomMetricsComponent: View {
    var title: String
    var subtitle: String
    var image: String
    var width: CGFloat
    var imageColor: Color
    var metricType: String
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: image)
                    .font(.custom("", fixedSize: width * 0.03))
                    .foregroundColor(imageColor)
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.custom("", fixedSize: width * 0.035))
                        .foregroundColor(.secondary)
                    Text("\(subtitle) \(metricType)")
                        .font(.custom("", fixedSize: width * 0.04))
                        .foregroundColor(.text)
                }
            }
        }
    }
}
