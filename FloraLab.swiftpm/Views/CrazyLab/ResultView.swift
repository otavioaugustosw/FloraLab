//
//  ResultView.swift
//  FloraLab
//
//  Created by Otávio Augusto on 21/02/25.
//

import SwiftUI

struct ResultView: View {
    
    @EnvironmentObject var viewmodel: PlantViewModel
    @Binding var navigationPath: NavigationPath
    private let gradient = Gradient(colors: [.black, .black])
    private let photoGradient = Gradient(colors: [.clear, Color(uiColor: .opaqueSeparator)])
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
    private var didPlantWin: Bool {
        viewmodel.finalScore >= viewmodel.plantScenario.CO2NecessaryToWin && viewmodel.missingResistances.isEmpty
    }
    private var goodEndingImage: String {
        viewmodel.plantScenario.goodEndingImage
    }
    private var badEndingImage: String {
        viewmodel.plantScenario.badEndingImage
    }
    private var goodEndingText: String {
        viewmodel.plantScenario.goodEndingText
    }
    
    private var badEndingText: String {
        viewmodel.plantScenario.badEndingText
    }

    var body: some View {
        ZStack {
            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            ScrollView{
                VStack(alignment: .center) {
                    Image(didPlantWin ? goodEndingImage : badEndingImage)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .overlay(alignment: .bottom) {
                            LinearGradient(gradient: photoGradient, startPoint: .top, endPoint: .bottom)
                                .frame(height: 150, alignment: .bottom)
                        }
                        .padding(.bottom, 30)
                    VStack {
                        Text(viewmodel.plantScenario.name)
                            .font(.system(size: fontSize * 1.5, weight: .semibold, design: .monospaced))
                            .padding(.bottom, 20)
                        VStack() {
                            Text(viewmodel.plantScenario.description)
                                .font(.system(size: fontSize, weight: .regular, design: .monospaced))
                                .padding(.bottom, 20)
                            
                            Text(didPlantWin ? goodEndingText : badEndingText)
                                .font(.system(size: fontSize, weight: .regular, design: .monospaced))
                                .padding(.bottom, 40)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        VStack {
                            Text("CO2 needed to restore the environment:")
                                .font(.system(size: fontSize * 0.80, weight: .regular, design: .monospaced))
                                .padding(.bottom, 20)
                            Text("\(viewmodel.plantScenario.CO2NecessaryToWin, specifier: "%.2f") kg of co2 savings")
                                .font(.system(size: fontSize, weight: .regular, design: .monospaced))
                                .padding(.bottom, 10)
                            ProgressView("", value: max(0,viewmodel.finalScore), total: viewmodel.plantScenario.CO2NecessaryToWin)
                                .tint(.green)
                            Text("Your super plant made:")
                                .font(.system(size: fontSize * 0.80, weight: .regular, design: .monospaced))
                                .padding(.vertical, 20)
                            Text("\(viewmodel.finalScore, specifier: "%.2f")kg of co2 savings")
                                .font(.system(size: fontSize, weight: .regular, design: .monospaced))
                                .padding(.bottom, 10)
                            Text(co2Comparisons(score: viewmodel.finalScore))
                                .font(.system(size: fontSize * 0.80, weight: .regular, design: .monospaced))
                                .padding(.top, 20)
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.white, lineWidth: 2)
                        )
                        
                    }
                    .frame(width: containerWidth * 0.95)
                    if !viewmodel.weaknessPenalties.isEmpty {
                        weaknessesPenalties
                            .padding(.top, 30)
                    }
                    if !viewmodel.missingResistances.isEmpty {
                        missingResistances
                            .padding(.top, 30)
                    }
                    Button{
                        withAnimation(.bouncy) {
                            navigationPath = NavigationPath()
                            navigationPath.append("CrazyLab")
                        }
                    } label: {
                        ZStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(.white)
                            Text("Back to the lab")
                                .padding(10)
                                .foregroundStyle(.black)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.black, lineWidth: 2)
                        )
                        
                        .frame(width: containerWidth * 0.9, height: containerHeight * 0.07)
                    }
                    .padding(.top, 30)
                    
                }
                .padding(.bottom, 50)
            }
            .ignoresSafeArea(.all)
        }
        .foregroundStyle(.white)
    }
    
    var missingResistances: some View {
        VStack {
            Text("Lacking Resistances")
                .font(.system(size: fontSize, weight: .regular, design: .monospaced))
                .padding(.bottom, 20)
                .padding(.horizontal, 40)
            
            ForEach(viewmodel.missingResistances, id: \.self) { resistances in
                HStack(alignment: .center) {
                    Image(systemName: resistances.icon)
                        .font(.system(size: fontSize * 2))
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 15)
                    VStack(alignment: .leading){
                        Text(resistances.rawValue)
                            .font(.system(size: fontSize, weight: .semibold, design: .monospaced))
                            .padding(.bottom, 10)
                        Text(viewmodel.plantScenario.badEndingFeedbacks[resistances] ?? "")
                            .font(.system(size: fontSize * 0.80, weight: .semibold, design: .monospaced))
                    }
                    .frame(maxWidth: containerWidth * 0.80, alignment: .leading)
                }
                .padding(.horizontal, 40)
                .padding(.top, 10)
                Rectangle().fill()
                    .frame(height: 1, alignment: .center)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 10)
            }
        }
    }
    
    var weaknessesPenalties: some View {
        VStack {
            Text("Weakness Penalties")
                .font(.system(size: fontSize, weight: .regular, design: .monospaced))
                .padding(.bottom, 20)
                .padding(.horizontal, 40)
            
            ForEach(viewmodel.weaknessPenalties.map{$0.key}, id: \.self) { weakness in
                HStack(alignment: .center) {
                    Image(systemName: weakness.icon)
                        .font(.system(size: fontSize * 2))
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 15)
                    VStack(alignment: .leading){
                        HStack{
                            Text(weakness.rawValue)
                                .font(.system(size: fontSize, weight: .semibold, design: .monospaced))
                            Text("- \(viewmodel.weaknessPenalties[weakness] ?? 0.0, specifier: "%.2f") co2 savings")
                                .font(.system(size: fontSize * 0.7, weight: .semibold, design: .monospaced))
                                .foregroundStyle(.orange)
                        }
                        .padding(.bottom, 10)
                        Text(viewmodel.plantScenario.weaknessFeedback[weakness] ?? "")
                            .font(.system(size: fontSize * 0.80, weight: .semibold, design: .monospaced))
                    }
                    .frame(maxWidth: containerWidth * 0.80, alignment: .leading)
                }
                .padding(.horizontal, 40)
                .padding(.top, 10)
                Rectangle().fill()
                    .frame(height: 1, alignment: .center)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 10)
                
            }
        }
    }
    
    func co2Comparisons(score: Double) -> String {
        switch score {
        case 2..<5:
            return "Your CO₂ reduction is equivalent to the emissions from burning about 1 liter of kerosene in a portable lamp."
        case 5..<8:
            return "Your CO₂ reduction is equivalent to the manufacturing emissions of roughly 2 cotton t-shirts."
        case 8..<12:
            return "Your CO₂ reduction is equivalent to the embodied emissions from producing one pair of jeans."
        case 12..<16:
            return "Your CO₂ reduction is equivalent to the emissions from a small natural gas water heater operating for about 30 minutes."
            
        case 16..<20:
            return "Your CO₂ reduction is equivalent to the emissions from burning roughly 4 liters of fuel oil in an industrial boiler."
        case 20..<25:
            return "Your CO₂ reduction is equivalent to the emissions produced by a medium-sized coal-fired power generator operating for about 3 minutes."
        case 25..<30:
            return "Your CO₂ reduction is equivalent to the embodied emissions in the production of about 3 pairs of jeans."
        case 30..<40:
            return "Your CO₂ reduction is equivalent to the emissions produced by a small industrial diesel generator running for roughly 8 minutes."
            
        case 40...65:
            return "Your CO₂ reduction is equivalent to the emissions produced by a large industrial boiler operating for about 10 to 15 minutes."
        default:
            return "Your CO₂ savings are extraordinary—a significant step toward a low-carbon future."
        }
    }


}

#Preview {
    @Previewable @State var path = NavigationPath()
    ResultView(navigationPath: $path)
        .environmentObject(PlantViewModel(basePlant: BasePlant.getPlant("sunflower")))
}
