
//
//  UserSavedPlants.swift
//  FloraLab
//
//  Created by Otávio Augusto on 16/02/25.
//

import SwiftUI
import SwiftData
import TipKit

struct UserSavedPlants: View {
    
    private var isLandscape: Bool {
        UIScreen.main.bounds.height < 500 ? true : false
    }
    private var buttonSize: CGFloat {
        isLandscape ? UIScreen.main.bounds.width * 0.08 : UIScreen.main.bounds.height * 0.08
    }
    private var fontSize: CGFloat  {
        isLandscape ? UIScreen.main.bounds.height * 0.04 : UIScreen.main.bounds.width * 0.04
    }
    private var containerWidth: CGFloat {
        isLandscape ? UIScreen.main.bounds.height * 0.95 : UIScreen.main.bounds.width * 0.95
    }
    private let gradient = Gradient(colors: [Color("Resin"), .clear])
    let deletePlantTip = DeletePlantTip()
    @EnvironmentObject var viewModel: PlantViewModel
    @Environment(\.modelContext) var modelContext
    @Query var userPlants: [UserPlant]
    @Binding var navigationPath: NavigationPath
    @State private var focusedPlant: UserPlant? = nil
    var body: some View {
        ZStack {
            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {

                if !userPlants.isEmpty {
                    TipView(deletePlantTip, arrowEdge: .bottom)
                        .tint(Color("Resin"))
                        .frame(maxWidth: containerWidth)
                    withAnimation(.bouncy) {
                        plantsScrollView
                    }
                } else {
                    withAnimation(.bouncy) {
                        noPlantsView
                    }
                }
            }
            .frame(maxWidth: isLandscape ? containerWidth : .infinity)
        }
        .navigationTitle("My plants")
        .task {
            do {
                try Tips.configure()
            }
            catch {
                print("Error initializing TipKit \(error.localizedDescription)")
            }
        }
        
    }
    var noPlantsView: some View {
        VStack {
            Image(systemName: "leaf.fill")
                .foregroundStyle(.white.opacity(0.6))
                .font(.system(size:fontSize * 4))
                .padding(.bottom, 30)
            Text("Let's create some plants first!")
                .foregroundStyle(.white.opacity(0.6))
                .font(.system(size: fontSize*1.5))
                .fontWeight(.semibold)
        }
    }
    
    var plantsScrollView: some View {
        ScrollView( isLandscape ? .vertical : .horizontal, showsIndicators: false) {
            if isLandscape {
                LazyVStack {
                    plantCards
                }
                .scrollTargetLayout()
            } else {
                LazyHStack {
                    plantCards
                }
                .scrollTargetLayout()
            }
        }
        .onScrollTargetVisibilityChange(idType: UserPlant.self) { plants in
            if !plants.isEmpty {
                withAnimation(.snappy) {
                    focusedPlant = plants[0]
                }
            }                        }
        .scrollTargetBehavior(.viewAligned)
        .contentMargins(20, for: .scrollContent)
    }
    
    var plantCards: some View {
        ForEach(userPlants, id: \.self) { plant in
            NavigationLink {
                PlantsDetailView(userPlant: plant)
            } label: {
                PlantsCard(plant: plant.getBasePlant(), forwiki: true, userPlant: plant)
            }
            .contextMenu {
                Button("Delete", systemImage: "trash.fill") {
                    guard let focusedPlant else { return }
                    withAnimation(.bouncy) {
                        modelContext.delete(focusedPlant)
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var path = NavigationPath()
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: UserPlant.self, configurations: config)
    let userplant = UserPlant(originalPlantID: BasePlant.getPlant("sunflower").id, customName: "Planta Teste")
    UserSavedPlants(navigationPath: $path)
        .modelContainer(container)
        .environmentObject(PlantViewModel(basePlant: BasePlant.getPlant("")))
        .onAppear {
            container.mainContext.insert(userplant)
        }
}
