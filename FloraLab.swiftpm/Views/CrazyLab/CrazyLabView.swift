//
//  CrazyLabView.swift
//  FloraLab
//
//  Created by Otávio Augusto on 13/02/25.
//

import SwiftUI
import TipKit
import SwiftData

struct CrazyLabView: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var viewModel: PlantViewModel
    @Query var userPlants: [UserPlant]
    @Binding var navigationPath: NavigationPath
    private var plantAlreadySaved: Bool {
        withAnimation(.bouncy){
            userPlants.contains(viewModel.userPlant)
        }
    }
    private let gradient = Gradient(colors: [Color("BlueCode"), .clear ])
    private let buttonSize = UIScreen.main.bounds.height * 0.13
    private let scoreTableSize = UIScreen.main.bounds.height * 0.07
    private let plant3DScreenSize = UIScreen.main.bounds.height * 0.35
    private var isLandscape: Bool {
        UIScreen.main.bounds.height < 500 ? true : false
    }
    
    let moveTip = movePlantTip()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    // shows only when the plant is ready
                    if viewModel.basePlant.name != "Unknown" {
                        TipView(moveTip, arrowEdge: .bottom)
                            .tint(Color("BlueCode"))
                            .padding(.top, 100)
                    }
                    PlantVisualizer(plant: viewModel.basePlant)
                        .frame(height: plant3DScreenSize)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 20)
                    
                    ScoreVisualizer(score: $viewModel.finalScore)
                        .frame(height: scoreTableSize)
                        .padding(.horizontal, 10)
                        .padding(.bottom, isLandscape ? 25 : 10)
                    
                    HStack {
                        NavigationLink(value: "PlantsCatalogue") {
                            LabButton(
                                title: "Create a Plant",
                                mainColor: Color("BlueCode"),
                                icon: "flask.fill",
                                design: .monospaced,
                                border: true
                            )
                        }
                    }
                    .frame(height: buttonSize)
                    .padding(.horizontal, 10)
                    .padding(.bottom, isLandscape ? 25 : 10)
                    
                    if viewModel.basePlant.name != "Unknown" {
                        withAnimation(.spring) {
                            HStack {
                                if viewModel.userPlant.geneKeys.count == 5, !plantAlreadySaved {
                                    Button {
                                        modelContext.insert(viewModel.userPlant)
                                    } label: {
                                        LabButton(
                                            title: "Save DNA",
                                            mainColor: Color("GreenApple"),
                                            icon: "leaf.fill",
                                            design: .monospaced,
                                            border: true
                                        )
                                    }
                                } else if plantAlreadySaved {
                                    LabButton(
                                        title: "Plant Saved",
                                        mainColor: Color("GreenApple"),
                                        icon: "hand.thumbsup.fill",
                                        design: .monospaced,
                                        border: true
                                    )
                                }
                                
                                Button {
                                    withAnimation(.bouncy) {
                                        viewModel.reset()
                                    }
                                } label: {
                                    LabButton(
                                        title: "Clear Lab",
                                        mainColor: Color("Resin"),
                                        icon: "bubbles.and.sparkles.fill", design: .monospaced,
                                        border: true
                                    )
                                }
                                
                            }
                            .frame(height: min(100, buttonSize))
                            .padding(.horizontal, 10)
                        }
                    }
                }
                .navigationTitle("Crazy Lab")
            }
        }
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
    CrazyLabView(navigationPath: $path)
        .environmentObject(PlantViewModel(basePlant: BasePlant.getPlant("")))
}

