
//
//  Plantpedia.swift
//  FloraLab
//
//  Created by Otávio Augusto on 16/02/25.
//

import SwiftUI
import SwiftData

struct Plantpedia: View {
    
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
    @EnvironmentObject var viewModel: PlantViewModel
    @Binding var navigationPath: NavigationPath
    @State private var focusedPlant: UserPlant? = nil
    var plants: [BasePlant] = BasePlant.getAll()
    var body: some View {
        ZStack {
            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                plantsScrollView
            }
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("Plantpedia")
        
    }
    
    var plantsScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(plants, id: \.self) { plant in
                    NavigationLink {
                        PlantsDetailView(plant: plant, forWiki: true)
                    } label: {
                        PlantsCard(plant: plant)
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .contentMargins(20, for: .scrollContent)
    }
}

#Preview {
    @Previewable @State var path = NavigationPath()
    Plantpedia(navigationPath: $path)
}
