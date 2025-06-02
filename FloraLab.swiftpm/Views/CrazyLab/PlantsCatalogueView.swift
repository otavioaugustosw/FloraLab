//
//  PlantsCatalogueView.swift
//  FloraLab
//
//  Created by Otávio Augusto on 16/02/25.
//

import SwiftUI
import TipKit

struct PlantsCatalogueView: View {
    @Binding var navigationPath: NavigationPath
    private var isLandscape: Bool {
        UIScreen.main.bounds.height < 500 ? true : false
    }
    
    private let gradient = Gradient(colors: [Color("BlueCode"), Color("Nightime")])
    private var buttonSize: CGFloat {
        isLandscape ? UIScreen.main.bounds.width * 0.08 : UIScreen.main.bounds.height * 0.08
    }
    private let tipSize = UIScreen.main.bounds.width * 0.90
    @EnvironmentObject var viewModel: PlantViewModel
    @State private var focusedPlant: BasePlant = .getPlant("")
    @State private var showChooseButton: Bool = true
    let plants = BasePlant.getAll3D()
    let cardInfoTip = CardsDetailsTip()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                TipView(cardInfoTip, arrowEdge: .bottom)
                    .onAppear {
                        withAnimation(.bouncy) {
                            showChooseButton = false
                        }
                    }
                    .onDisappear {
                        withAnimation(.bouncy) {
                            showChooseButton = true
                        }
                    }
                    .frame(maxWidth: tipSize)
                    .tint(Color("BlueCode"))
                if isLandscape {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack {
                            ForEach(plants, id: \.self) { plant in
                                NavigationLink {
                                    PlantsDetailView(plant: plant)
                                } label: {
                                    PlantsCard(plant: plant, hasARButton: false)
                                }
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .onScrollTargetVisibilityChange(idType: BasePlant.self) { plants in
                        if !plants.isEmpty {
                            withAnimation(.snappy) {
                                focusedPlant = plants[0]
                            }
                        }                        }
                    .scrollTargetBehavior(.viewAligned)
                    .contentMargins(20, for: .scrollContent)
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(plants, id: \.self) { plant in
                                NavigationLink {
                                    PlantsDetailView(plant: plant)
                                } label: {
                                    PlantsCard(plant: plant, hasARButton: false)
                                }
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .onScrollTargetVisibilityChange(idType: BasePlant.self) { plants in
                        if !plants.isEmpty {
                            withAnimation(.snappy) {
                                focusedPlant = plants[0]
                            }
                        }                        }
                    .scrollTargetBehavior(.viewAligned)
                    .contentMargins(20, for: .scrollContent)
                }
                if showChooseButton {
                    Button {
                        viewModel.updatePlant(focusedPlant)
                        navigationPath.append("GenesCatalogue")
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(.ultraThinMaterial)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(.black, lineWidth: 2)
                                )
                            VStack(alignment: .leading) {
                                Text("Choose \(focusedPlant.name)")
                                    .font(.system(.title3, design: .monospaced))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .lineLimit(1)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                        .frame(maxHeight: buttonSize)
                    }
                }
            }
        }
        .navigationTitle("Choose your base")
        .task {
            do {
                try Tips.configure()
            }
            catch {
                print("Error initializing TipKit \(error.localizedDescription)")
            }
        }
        
    }
}

#Preview {
    @Previewable @State var path = NavigationPath()
    PlantsCatalogueView(navigationPath: $path)
        .environmentObject(PlantViewModel(basePlant: BasePlant.getPlant("")))
}
