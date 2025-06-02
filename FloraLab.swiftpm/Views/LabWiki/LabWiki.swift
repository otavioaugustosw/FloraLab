//
//  LabWiki.swift
//  FloraLab
//
//  Created by Otávio Augusto on 21/02/25.
//

import SwiftUI

struct LabWiki: View {
    private var isLandscape: Bool {
        UIScreen.main.bounds.height < 500 ? true : false
    }
    private var containerWidth: CGFloat {
        isLandscape ? UIScreen.main.bounds.height * 0.95 : UIScreen.main.bounds.width * 0.95
    }
    private var containerHeight: CGFloat {
        isLandscape ? UIScreen.main.bounds.width * 0.90 : UIScreen.main.bounds.height * 0.90
    }
    private var fontSize: CGFloat  {
        isLandscape ? UIScreen.main.bounds.height * 0.04 : UIScreen.main.bounds.width * 0.04
    }
    private var buttonSize: CGFloat {
        isLandscape ? UIScreen.main.bounds.width * 0.16 : UIScreen.main.bounds.height * 0.16
    }
    private let gradient = Gradient(colors: [Color("Resin"), .clear])
    @Binding var navigationPath: NavigationPath

    var body: some View {
        ZStack {
            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    logo
                        .foregroundStyle(.white)
                    Spacer()
                    HStack {
                        NavigationLink(value: "Plantpedia") {
                            LabButton(
                                title: "Plantpedia",
                                mainColor: Color("Resin"),
                                icon: "book.fill"
                            )
                        }
                        
                        NavigationLink(value: "Genepedia") {
                            LabButton(
                                title: "Genepedia",
                                mainColor: Color("Resin"),
                                icon: "atom"
                            )
                        }
                    }
                    .frame(height: buttonSize)
                    
                    NavigationLink(value: "UserSavedPlants") {
                        LabButton(
                            title: "My Saved Plants",
                            mainColor: Color("Resin"),
                            icon: "leaf.fill"
                        )
                    }
                    .frame(height: buttonSize)
                    Spacer()
                    Spacer()
                }
                .padding(.horizontal, 10)
                .navigationTitle("LabWiki")
            }
        }
    }
    
    var logo: some View {
        HStack{
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 5) {
                    Image(systemName: "tree")
                        .font(.system(size: fontSize * 3))
                    Text("International System of Super Plants")
                        .font(.system(size: fontSize * 0.8, weight: .semibold, design: .monospaced))
                        .padding(.bottom, 40)
                }
                .frame(maxWidth: containerWidth*0.35, alignment: .leading)
                .padding(.top)
                .padding(.leading, 5)
            }
            Spacer()
        }
    }
}

#Preview {
    @Previewable @State var path = NavigationPath()
    LabWiki(navigationPath: $path)
        .environmentObject(PlantViewModel(basePlant: BasePlant.getPlant("")))
}
