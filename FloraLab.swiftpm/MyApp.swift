import SwiftUI
import SwiftData

@main
struct MyApp: App {
    @StateObject private var viewModel: PlantViewModel = PlantViewModel(basePlant: BasePlant.getPlant(""))
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewModel)
                .modelContainer(for: UserPlant.self)
        }
    }
}
