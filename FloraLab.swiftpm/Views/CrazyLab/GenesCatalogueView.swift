//
//  GenesCatalogueView.swift
//  FloraLab
//
//  Created by Otávio Augusto on 17/02/25.
//
import SwiftUI

struct GenesCatalogueView: View {
    @EnvironmentObject var viewModel: PlantViewModel
    @Binding var navigationPath: NavigationPath
    private var isLandscape: Bool {
        UIScreen.main.bounds.height < 500 ? true : false
    }
    private var geneCounterHeight: CGFloat {
        isLandscape ? UIScreen.main.bounds.height * 0.20 : UIScreen.main.bounds.width * 0.20
    }
    private var geneCapsuleHeight: CGFloat {
        isLandscape ? UIScreen.main.bounds.height * 0.20 : UIScreen.main.bounds.width * 0.20
    }
    private var buttonSize: CGFloat {
        isLandscape ? UIScreen.main.bounds.height * 0.14 : UIScreen.main.bounds.width * 0.14
    }
    var body: some View {
        // keep this geometry
        let genesChosen = viewModel.userPlant.geneKeys.count
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Nightime"), .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    GeneCounter(userPlant: viewModel.userPlant)
                        .frame(height: geneCounterHeight)
                        .padding(.bottom, 20)
                        .padding(.top, isLandscape ? 10 : 40)
                    
                    GeneCapsule(
                        text: String(format: "Saves %.1fx CO2", viewModel.userPlant.co2Multiplier),
                        icon: "carbon.dioxide.cloud.fill"
                    )
                    .frame(height: geneCapsuleHeight)
                    .padding(.bottom, genesChosen == 5 ? 10 : 0)
                    
                    if genesChosen == 5 {
                        withAnimation(.snappy) {
                            NavigationLink(value: "PlantOverview") {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill()
                                        .foregroundStyle(.ultraThinMaterial)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(.black, lineWidth: 2)
                                        )
                                    Text("Continue")
                                        .font(.system(.title3, design: .monospaced))
                                        .fontWeight(.semibold)
                                        .lineLimit(1)
                                        .foregroundStyle(.white)
                                    
                                }
                                .frame(height: buttonSize)
                                .padding(.top, 20)
                            }
                        }
                    }
                    
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ForEach(viewModel.availableGenes) { gene in
                                Button {
                                    viewModel.toggleGene(gene)
                                } label: {
                                    GeneCell(gene: gene, userPlant: viewModel.userPlant)
                                }
                                .sensoryFeedback(.selection, trigger: viewModel.userPlant.geneKeys)
                            }
                        }
                        .overlay(alignment: .top) {
                            LinearGradient(gradient: Gradient(colors: [Color("Nightime").opacity(0.6), .clear]), startPoint: .top, endPoint: .bottom)
                                .ignoresSafeArea()
                                .frame(maxWidth: .infinity , maxHeight: 30)
                        }
                        .padding(.top, 10)
                    }
                    .padding(.top, 40)
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.height * 0.95)
            .padding(.horizontal, 10)
        }
        .navigationTitle("Choose your genes")
    }
}

#Preview {
    @Previewable @State var path = NavigationPath()
    GenesCatalogueView(navigationPath: $path)
        .environmentObject(PlantViewModel(basePlant: BasePlant.getPlant("sunflower")))
}
