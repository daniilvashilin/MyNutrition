import SwiftUI
import Charts

struct WeightChartView: View {
    @EnvironmentObject var nutritionService: NutritionService
    var width: CGFloat
    var height: CGFloat
    @Binding var addButtonPressed: Bool
    var filteredWeightHistory: [WeightEntry] {
        guard let data = nutritionService.nutritionData else { return [] }
        let convertedHistory = data.weightHistory.map { $0.toWeightEntry() }
        var history = convertedHistory.sorted(by: { $0.date < $1.date })
        let today = Date()
        if let lastEntry = history.last, !Calendar.current.isDate(lastEntry.date, inSameDayAs: today) {
            history.append(WeightEntry(date: today, weight: lastEntry.weight))
        }
        
        return history
    }

    var body: some View {
        GroupBox {
            VStack(alignment: .leading) {
                HStack {
                    Text("Weight")
                        .font(.headline)
                    Text("Last 90 days")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Button {
                        addButtonPressed = true
                    } label: {
                        Text("+")
                            .foregroundStyle(.text)
                            .font(.headline.bold())
                    }
                }
                
                Chart {
                    ForEach(filteredWeightHistory) { entry in
                        LineMark(
                            x: .value("Date", entry.date),
                            y: .value("Weight", entry.weight)
                        )
                        .foregroundStyle(.green)
                    }

                    ForEach(filteredWeightHistory) { entry in
                        PointMark(
                            x: .value("Date", entry.date),
                            y: .value("Weight", entry.weight)
                        )
                        .symbol(Circle())
                        .symbolSize(10)
                        .foregroundStyle(.green)
                    }
                }
                .chartXAxis {
                    AxisMarks(values: generateXAxisDates(from: filteredWeightHistory)) { value in
                        if let dateValue = value.as(Date.self) {
                            AxisValueLabel(format: .dateTime.day().month(.abbreviated))
                        }
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading) {
                        AxisGridLine()
                        AxisValueLabel()
                    }
                }
                .frame(height: height * 0.7)
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

func generateXAxisDates(from history: [WeightEntry]) -> [Date] {
    guard let firstDate = history.first?.date, let lastDate = history.last?.date else {
        return []
    }
    
    let calendar = Calendar.current
    var dates: [Date] = []
    
    let interval = (calendar.dateComponents([.day], from: firstDate, to: lastDate).day ?? 1) / 4
    var currentDate = firstDate
    
    while currentDate <= lastDate {
        dates.append(currentDate)
        currentDate = calendar.date(byAdding: .day, value: interval, to: currentDate) ?? lastDate
    }
    
    dates.append(lastDate)
    return dates
}


struct WeightEntry: Identifiable, Codable {
    var id: String = UUID().uuidString
    var date: Date
    var weight: Double
}

extension Nutrition.WeightEntry {
    func toWeightEntry() -> WeightEntry {
        return WeightEntry(
            id: id,
            date: date,
            weight: weight
        )
    }
}
