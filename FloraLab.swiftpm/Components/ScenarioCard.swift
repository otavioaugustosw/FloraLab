//
//  ScenarioCard.swift
//  FloraLab
//
//  Created by Otávio Augusto on 22/02/25.
//
import SwiftUI

struct ScenarioCard: View {
    @EnvironmentObject var viewmodel: PlantViewModel
    @Binding var navigationPath: NavigationPath
    private var isLandscape: Bool {
        UIScreen.main.bounds.height < 500 ? true : false
    }
    private var containerWidth: CGFloat {
        isLandscape ? UIScreen.main.bounds.height * 0.85 : UIScreen.main.bounds.width * 0.85
    }
    private var containerHeight: CGFloat {
        isLandscape ? UIScreen.main.bounds.width * 0.70 : UIScreen.main.bounds.height * 0.70
    }
    private var didPlantWin: Bool {
        viewmodel.finalScore >= viewmodel.plantScenario.CO2NecessaryToWin && viewmodel.missingResistances.isEmpty
    }
    private var goodEndingImage: String {
        viewmodel.plantScenario.goodEndingImage
    }
    private var badEndingImage: String {
        viewmodel.plantScenario.badEndingImage
    }
    private var fontSize: CGFloat  {
        isLandscape ? UIScreen.main.bounds.height * 0.04 : UIScreen.main.bounds.width * 0.04
    }
    private let gradient = Gradient(colors: [.clear, Color("GreenApple")])
    private let photoGradient = Gradient(colors: [.black, .black, .black, Color.clear])
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false
    @State var isCalled = false
    var offSetCard: CGFloat {
        isCalled ? 0 : containerWidth * 1.5
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            ZStack{
                frontCard
                backCard
            }
            .offset(y: offSetCard)
            .shadow(color: .black.opacity(0.2), radius: 12)
        }
        .onAppear { callCard() }
    }
    
    func callCard() {
        withAnimation(.bouncy(duration: 0.6).delay(1)) {
            isCalled.toggle()
        } completion: {
            flipCard()
        }
        viewmodel.setGameResult()
    }
    func flipCard() {
        isFlipped.toggle()
        if isFlipped {
            withAnimation(.linear(duration: 0.3)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: 0.3).delay(0.3)) {
                frontDegree = 0
            } completion: {
                sleep(1)
                navigationPath = NavigationPath()
                navigationPath.append("Result")
            }
        } else {
            withAnimation(.linear(duration: 0.3)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: 0.3).delay(0.3)) {
                backDegree = 0
            }
        }
    }
    
    var frontCard: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.thickMaterial)
            VStack{
                Image(didPlantWin ? goodEndingImage : badEndingImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: containerHeight * 0.50)
                    .clipShape(.rect(topLeadingRadius: 12, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 12))
                    .mask(alignment: .bottom) {
                        LinearGradient(gradient: photoGradient, startPoint: .top, endPoint: .bottom)
                    }
                    .frame(maxWidth: .infinity)
                Text(viewmodel.plantScenario.name)
                    .font(.system(size: fontSize * 1.5, weight: .semibold, design: .monospaced))
                    .padding(.bottom, 20)
                Spacer()
            }
        }
        .frame(maxWidth: containerWidth, maxHeight: containerHeight)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.black, lineWidth: 2)
        )
        .rotation3DEffect(Angle(degrees: frontDegree), axis: (x:0, y:1, z:0))
    }
    
    var backCard: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.thickMaterial)
            VStack{
                Spacer()
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: fontSize*8))
                    .foregroundStyle(Color("Sun").shadow(.inner(color: .orange, radius: 12)).shadow(.drop(color:.orange.opacity(0.6), radius: 2)))
                Spacer()

            }
        }
        .frame(maxWidth: containerWidth, maxHeight: containerHeight)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.black, lineWidth: 2)
        )
        .rotation3DEffect(Angle(degrees: backDegree), axis: (x:0, y:1, z:0))
    }
}

#Preview {
    @Previewable @State var path = NavigationPath()
    ScenarioCard(navigationPath: $path)
        .environmentObject(PlantViewModel(basePlant: BasePlant.getPlant("sunflower")))
}
