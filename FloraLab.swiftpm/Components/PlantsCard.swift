//
//  PlantsCard.swift
//  FloraLab
//
//  Created by Otávio Augusto on 12/02/25.
//

import SwiftUI
import QuickLook
import TipKit

struct PlantsCard: View {
    private var imageSize: CGFloat {
        isLandscape ? UIScreen.main.bounds.height * 0.60 : UIScreen.main.bounds.height * 0.35
    }
    
    private var cardWSize: CGFloat {
        isLandscape ? UIScreen.main.bounds.height * 0.95 : UIScreen.main.bounds.width * 0.95
    }
    
    private var fontSize: CGFloat {
        isLandscape ? UIScreen.main.bounds.height * 0.05 : UIScreen.main.bounds.height * 0.03
    }
    
    private var motionIntensity: Double {
        hasARButton ? 5 : 0
    }
    private var isLandscape: Bool {
        UIScreen.main.bounds.height < 500 ? true : false
    }
    private let gradient = Gradient(colors: [.black, .black, .black, Color.clear])
    private var arTip = CardARTip()
    @StateObject private var motion = MotionManager()
    @State private var url: URL?
    let plant: BasePlant
    let userPlant: UserPlant?
    var hasARButton: Bool
    var forwiki: Bool
    

    init(plant: BasePlant, hasARButton: Bool = false, forwiki: Bool = false, userPlant: UserPlant? = nil) {
        self.plant = plant
        self.hasARButton = hasARButton
        self.forwiki = forwiki
        self.userPlant = userPlant
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            if hasARButton {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.white.opacity(0.60))
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.regularMaterial)
            }
            
            VStack {
                plantImage()
                plantInfo()
                    .frame(width: cardWSize * 0.95)
                Spacer()
            }

        }
        .frame(maxWidth: cardWSize, maxHeight: cardWSize * 1.6)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.black, lineWidth: 2)
        )
        .rotation3DEffect(.degrees(motion.y * motionIntensity), axis: (x: -1, y: 0, z: 0))
        .rotation3DEffect(.degrees(motion.x * motionIntensity), axis: (x: 0, y: 1, z: 0))
        .task {
            do {
                try Tips.configure()
            } catch {
                print("tipkit error: \(error.localizedDescription)")
            }
        }
    }
    // MARK: Subviews
    
    private func plantImage() -> some View {
        Image(plant.imageName ?? "default")
            .resizable()
            .scaledToFill()
            .frame(height: imageSize)
            .clipShape(.rect(topLeadingRadius: 12, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 12))
            .mask(alignment: .bottom) {
                LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
            }
    }

    private func plantInfo() -> some View {
        VStack(alignment: .leading, spacing: 25) {
            if forwiki {
                titleRowPlantPedia()
            } else {
                titleRow()
            }
            descriptionText()
            if hasARButton {
                arView()
            }
        }
        .padding(.leading, hasARButton ? 0 : 10)
    }

    private func titleRow() -> some View {
        HStack {
            Text(plant.name)
                .font(.system(.title3, design: .monospaced))
                .fontWeight(.semibold)
                .foregroundStyle(Color(uiColor: .label))
                .lineLimit(1)
            geneIcons()
        }
    }
    private func titleRowPlantPedia() -> some View {
        return HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 10) {
                HStack{
                    Text(userPlant?.customName ?? "Unknown")
                        .font(.system(size:fontSize * 0.8, design: .monospaced))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(uiColor: .label))
                        .lineLimit(1)
                    geneIcons()
                }
                Text("A \(plant.name) modification")
                    .font(.system(size: fontSize * 0.5, design: .monospaced))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(uiColor: .label))
                    .lineLimit(1)
            }
        }
    }

    private func geneIcons() -> some View {
        HStack {
            ForEach(plant.geneKeys.map { Gene.getGene($0) }) { gene in
                Image(systemName: gene.icon)
                    .foregroundStyle(Color(gene.mainColor))
                    .font(.system(size: fontSize * 0.80))
                    .fontWeight(.bold)
            }
        }
    }

    private func descriptionText() -> some View {
        Text(plant.description)
            .font(.system(size: 14, design: .monospaced))
            .fontWeight(.regular)
            .foregroundStyle(Color(uiColor: .label))
            .lineLimit(5, reservesSpace: true)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func arView() -> some View {
        HStack {
            Spacer()
            TipView(arTip, arrowEdge: .trailing)
                .tint(Color("BlueCode"))
            arButton()
        }
        .padding()
    }

    private func arButton() -> some View {
        Button {
            url = Bundle.main.url(forResource: plant.name, withExtension: "usdz")
        } label: {
            ZStack {
                Circle()
                    .foregroundStyle(Color("BlueCode"))
                    .frame(width: 45, height: 45)
                Image(systemName: "view.3d")
                    .foregroundStyle(.white)
                    .font(.system(size: fontSize * 0.80))
                    .fontWeight(.bold)
            }
        }
        .quickLookPreview($url)
    }
}

#Preview {
    ZStack {
        Color("Resin")
            .ignoresSafeArea()
            VStack {
                PlantsCard(plant: .getPlant("corn"), hasARButton: true, forwiki: true)
        }
    }
}
