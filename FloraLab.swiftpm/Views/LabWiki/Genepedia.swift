//
//  Genepedia.swift
//  FloraLab
//
//  Created by Otávio Augusto on 17/02/25.
//
import SwiftUI
import CoreHaptics

struct Genepedia: View {
    private var circleSize: CGFloat {
        isLandscape ? UIScreen.main.bounds.height * 0.13 : UIScreen.main.bounds.width * 0.13
    }
    private var fontSize: CGFloat {
        isLandscape ? UIScreen.main.bounds.width * 0.017 : UIScreen.main.bounds.height * 0.017
    }
    @EnvironmentObject var viewModel: PlantViewModel
    @Binding var navigationPath: NavigationPath
    private var isLandscape: Bool {
        UIScreen.main.bounds.height < 500 ? true : false
    }
    private var containerWidth: CGFloat {
        isLandscape ? UIScreen.main.bounds.height * 0.95 : UIScreen.main.bounds.width * 0.95
    }
    private var containerHeight: CGFloat {
        isLandscape ? UIScreen.main.bounds.width * 0.90 : UIScreen.main.bounds.height * 0.90
    }
    private var adaptiveColumn: [GridItem]  {
        [
            GridItem(.flexible(minimum: 0, maximum: containerWidth)),
            GridItem(.flexible(minimum: 0, maximum: containerWidth)),
            GridItem(.flexible(minimum: 0, maximum: containerWidth)),
            GridItem(.flexible(minimum: 0, maximum: containerWidth)),

        ]
    }
    @State private var selectedGene: Gene?
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Resin"), .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            ScrollView() {
                GeneVisualizer(gene: selectedGene)
                    .frame(height: containerHeight * 0.45)
                    .padding(.horizontal, 5)
                VStack {
                    GeneSocket(selectedGene)
                        .frame(width: containerWidth * 0.30, height: containerHeight * 0.10)
                }
                .padding(.vertical, 20)
                LazyHGrid(rows: adaptiveColumn, spacing: 10) {
                    ForEach(Gene.getAll()) { gene in
                        Button {
                            toggleGene(gene)
                        } label: {
                            geneIcon(gene: gene)
                        }
                        .sensoryFeedback(.selection, trigger: selectedGene?.key)
                    }
                }
                .frame(maxWidth: containerWidth * 0.95)
            }
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("Genepedia")
    }
    
    private func geneIcon(gene: Gene) -> some View {
        Circle()
            .foregroundStyle(Color(gene.mainColor).shadow(.inner(color: .white, radius: 5)))
            .overlay {
                Circle().stroke(.black, lineWidth: 2)
                Image(systemName: gene.icon)
                    .foregroundStyle(.white)
                    .font(.system(size: fontSize * 1.7))
                    .fontWeight(.bold)
            }
            .frame(width: circleSize)
    }
    
    func toggleGene(_ gene: Gene) {
        if gene.key == selectedGene?.key {
            withAnimation(.bouncy) {
                selectedGene = nil
            }
        } else {
            withAnimation(.bouncy) {
                selectedGene = gene
            }
        }
    }
}

#Preview {
    @Previewable @State var path = NavigationPath()
    Genepedia(navigationPath: $path)
        .environmentObject(PlantViewModel(basePlant: BasePlant.getPlant("")))
}


struct GeneSocket: View {
    private var isLandscape: Bool {
        UIScreen.main.bounds.height < 500 ? true : false
    }
    private var circleSize: CGFloat {
        isLandscape ? UIScreen.main.bounds.height * 0.12 : UIScreen.main.bounds.width * 0.12
    }
    private var fontSize: CGFloat {
        isLandscape ? UIScreen.main.bounds.width * 0.03 : UIScreen.main.bounds.height * 0.03
    }
    let gene: Gene?
    
    init(_ gene: Gene?) {
        self.gene = gene
    }
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(.black.shadow(.inner(color: Color("Resin"), radius: 14)))
            
            HStack(spacing: 10) {
                if let gene {
                    geneCircle(gene)
                } else {
                    emptySlot()
                }
            }
        }
        .shadow(color: Color("Resin").opacity(0.3), radius: 13)
        .frame(maxWidth: .infinity)
        .overlay(
            Circle()
                .stroke(Color("Resin").opacity(0.14), lineWidth: 2)
        )
    }
    
    // MARK: Subviews
    
    private func emptySlot() -> some View {
        Circle()
            .stroke(Color("Resin"), lineWidth: 2)
            .frame(width: circleSize)
    }
    
    private func geneCircle(_ gene: Gene) -> some View {
        Circle()
            .foregroundStyle(Color(gene.mainColor).shadow(.inner(color: .white, radius: 5)))
            .overlay {
                Circle()
                    .stroke(Color("Resin"), lineWidth: 2)
                Image(systemName: gene.icon)
                    .foregroundStyle(.white)
                    .font(.system(size: fontSize))
                    .fontWeight(.bold)
            }
            .frame(width: circleSize)
    }
}
