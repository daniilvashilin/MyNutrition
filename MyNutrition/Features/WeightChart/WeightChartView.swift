import SwiftUI
import Charts

struct WeightChartView: View {
    @EnvironmentObject var nutritionService: NutritionService
    @State private var selectedRange: WeightRange = .week

    var width: CGFloat
    var height: CGFloat

    var filteredWeightHistory: [WeightEntry] {
        guard let data = nutritionService.nutritionData else { return [] }
        let convertedHistory = data.weightHistory.map { $0.toWeightEntry() }
        return filterWeightHistory(for: selectedRange, history: convertedHistory)
            .sorted(by: { $0.date < $1.date }) // Сортировка по возрастанию даты
    }

    var body: some View {
        GroupBox {
            VStack {
                HStack {
                    Text("Weight Progress")
                        .font(.headline)
                    Spacer()
                }
                .padding(.horizontal)

                Picker("Range", selection: $selectedRange) {
                    Text("Week").tag(WeightRange.week)
                    Text("Month").tag(WeightRange.month)
                    Text("Year").tag(WeightRange.year)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .animation(nil, value: selectedRange)

                Chart {
                    ForEach(filteredWeightHistory) { entry in
                        LineMark(
                            x: .value("Date", entry.date),
                            y: .value("Weight", entry.weight)
                        )
                        .interpolationMethod(.catmullRom)
                    }

                    if let firstEntry = filteredWeightHistory.first {
                        PointMark(
                            x: .value("Date", firstEntry.date),
                            y: .value("Weight", firstEntry.weight)
                        )
                        .symbol(Circle())
                        .foregroundStyle(.green)
                        .symbolSize(50)
                    }

                    if let lastEntry = filteredWeightHistory.last {
                        PointMark(
                            x: .value("Date", lastEntry.date),
                            y: .value("Weight", lastEntry.weight)
                        )
                        .symbol(Circle())
                        .foregroundStyle(.blue)
                        .symbolSize(50)
                    }

                    if let data = nutritionService.nutritionData {
                        RuleMark(
                            y: .value("Target Weight", data.goalWeight)
                        )
                        .foregroundStyle(.red)
                    }
                }
//                .chartXScale(domain: filteredWeightHistory.first?.date ?? Date()...filteredWeightHistory.last?.date ?? Date())
                .chartXAxis {
                    AxisMarks(values: filteredWeightHistory.map { $0.date }) { value in
                        if let dateValue = value.as(Date.self) {
                            switch selectedRange {
                            case .week:
                                AxisValueLabel(format: .dateTime.day().month(.abbreviated)) // "15 Jan"
                            case .month:
                                AxisValueLabel(format: .dateTime.month(.abbreviated)) // "Jan"
                            case .year:
                                AxisValueLabel(format: .dateTime.year()) // "2025"
                            }
                        }
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading) {
                        AxisValueLabel()
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

// Функция для фильтрации данных
func filterWeightHistory(for range: WeightRange, history: [WeightEntry]) -> [WeightEntry] {
    let calendar = Calendar.current
    let now = Date()
    
    switch range {
    case .week:
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: now) ?? now
        return history.filter { $0.date >= weekAgo }
    case .month:
        let monthAgo = calendar.date(byAdding: .month, value: -1, to: now) ?? now
        return history.filter { $0.date >= monthAgo }
    case .year:
        let yearAgo = calendar.date(byAdding: .year, value: -1, to: now) ?? now
        return history.filter { $0.date >= yearAgo }
    }
}

struct WeightEntry: Identifiable, Codable {
    var id: String = UUID().uuidString
    var date: Date
    var weight: Double
}

enum WeightRange {
    case week
    case month
    case year
}

// Преобразование `Nutrition.WeightEntry` в глобальный `WeightEntry`
extension Nutrition.WeightEntry {
    func toWeightEntry() -> WeightEntry {
        return WeightEntry(
            id: id,
            date: date,
            weight: weight
        )
    }
}


