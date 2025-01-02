import SwiftUI

struct IPadSplitView: View {
    @State private var selectedTab: NavigationTabModel.TableViewSection = .home
    let viewModel: BaseAuthViewModel
    let authService: AuthService
    let nutritionService: NutritionService

    var body: some View {
        NavigationSplitView {
            // Левый список (Master)
            List(NavigationTabModel.TableViewSection.allCases, id: \.self) { tab in
                Button {
                    selectedTab = tab
                } label: {
                    HStack {
                        Image(systemName: tab.image ?? "questionmark")
                            .font(.largeTitle)
                        Text(tab.title ?? "No Title")
                            .font(.title3)
                    }
                    .padding()
                    .background(selectedTab == tab ? Color.green.opacity(0.3) : Color.clear)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .scaleEffect(selectedTab == tab ? 1.1 : 1)
                    .animation(.spring(), value: selectedTab == tab) // Анимация
                }
                .buttonStyle(.plain)
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 240, idealWidth: 300, maxWidth: 320)
        } detail: {
            // Детальная часть
            navigationTabs(for: selectedTab)
        }
        .navigationSplitViewStyle(.balanced) // Сбалансированный стиль
    }

    @ViewBuilder
    private func navigationTabs(for option: NavigationTabModel.TableViewSection) -> some View {
        switch option {
        case .home:
            TestHomePageView(
                viewModel: viewModel,
                authservice: authService
            )
            .environmentObject(nutritionService)
            .navigationTitle("") // Убираем лишний заголовок
            .toolbar {
                // Убираем ToolBar, если он лишний
            }
        case .charts:
            ChartsTabView()
                .navigationTitle("") // Убираем заголовок
        case .recepices:
            RecipesTabView()
                .navigationTitle("") // Убираем заголовок
        }
    }
}

struct ChartsTabView: View {
    var body: some View {
        VStack {
            Text("Charts Tab")
                .font(.largeTitle)
            Spacer()
        }
        .padding()
    }
}

struct RecipesTabView: View {
    var body: some View {
        VStack {
            Text("Recipes Tab")
                .font(.largeTitle)
            Spacer()
        }
        .padding()
    }
}
