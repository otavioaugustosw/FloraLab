//
//  HomeView.swift
//  FloraLab
//
//  Created by Otávio Augusto on 12/02/25.
//

import SwiftUI

struct HomeView: View {
    private let gradient = Gradient(colors: [Color("GreenApple"), .clear])
    private var isLandscape: Bool {
        UIScreen.main.bounds.height < 500 ? true : false
    }
    private var buttonSize: CGFloat {
        isLandscape ? UIScreen.main.bounds.width * 0.16 : UIScreen.main.bounds.height * 0.16
    }
    private var cardWSize: CGFloat {
        isLandscape ? UIScreen.main.bounds.height * 0.95 : UIScreen.main.bounds.width * 0.95
    }
    @State private var navigationPath = NavigationPath()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        Spacer()
                        HStack {
                            NavigationLink(value: "CrazyLab") {
                                LabButton(
                                    title: "Crazy Lab",
                                    mainColor: Color("GreenApple"),
                                    icon: "atom"
                                )
                            }
                            NavigationLink(value: "LabWiki") {
                                LabButton(
                                    title: "LabWiki",
                                    mainColor: Color("GreenApple"),
                                    icon: "rectangle.and.text.magnifyingglass"
                                )
                            }
                        }
                        .padding(.horizontal, 10)
                        .frame(height: buttonSize)
                        Text("Plant Spotlight")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 10)
                        
                        PlantsCard(plant: .getAll().randomElement() ?? .defaultPlant)
                        Spacer()
                    }
                    .navigationTitle("FloraLab")
                    .navigationDestination(for: String.self) { destination in
                        switch destination {
                        case "CrazyLab":
                            CrazyLabView(navigationPath: $navigationPath)
                                .tint(Color("Rain"))
                        case "Plantpedia":
                            Plantpedia(navigationPath: $navigationPath)
                        case "Genepedia":
                            Genepedia(navigationPath: $navigationPath)
                        case "UserSavedPlants":
                            UserSavedPlants(navigationPath: $navigationPath)
                        case "LabWiki":
                            LabWiki(navigationPath: $navigationPath)
                                .tint(Color("Resin"))
                        case "PlantsCatalogue":
                            PlantsCatalogueView(navigationPath: $navigationPath)
                        case "GenesCatalogue":
                            GenesCatalogueView(navigationPath: $navigationPath)
                        case "PlantOverview":
                            PlantOverView(navigationPath: $navigationPath)
                        case "CardSorting":
                            ScenarioCard(navigationPath: $navigationPath)
                        case "Result":
                            ResultView(navigationPath: $navigationPath)
                        default:
                            Text("Error page not found")
                        }
                    }
                }
            }
        }
        .tint(Color("GreenApple"))
    }
}

#Preview {
    HomeView()
        .environmentObject(PlantViewModel(basePlant: BasePlant.getPlant("")))
}

