//
//  PlantOverView:.swift
//  FloraLab
//
//  Created by Otávio Augusto on 19/02/25.
//

import SwiftUI

struct PlantOverView: View {
    @EnvironmentObject var viewmodel: PlantViewModel
    @State private var currentIndex = 0
    @Binding var navigationPath: NavigationPath
    private let scenes: [String] = [
        "intro", "naming", "cardStats", "confirm"
    ]
    private let gradient = Gradient(colors: [.clear, Color("GreenApple")])
    
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
    private var isNameNotEmpty: Bool {
        withAnimation() {
            viewmodel.userPlant.customName.isEmpty ? false : true
        }
    }
    private var canContinue: Int {
        withAnimation() {
            isNameNotEmpty && continueToggle ? scenes.count : 2
        }
    }
    
    @State private var continueToggle: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    
                    TabView(selection: $currentIndex) {
                        
                        ForEach(0..<canContinue, id: \.self) { index in
                            VStack(alignment: .center) {
                                switch scenes[index] {
                                case "intro":
                                    introView
                                case "naming":
                                    namingView
                                case "cardStats":
                                    cardStats
                                case "confirm":
                                    confirmView
                                default:
                                    introView
                                }
                                
                            }
                            .tag(index)
                        }
                    }
                    .frame(height: containerHeight * 0.94)
                    .tabViewStyle(PageTabViewStyle())
                    
                }
                .frame(width: containerWidth, height: containerHeight, alignment: .center)
            }
            
        }
    }
    
    // MARK: Subviews
    var logo: some View {
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
    }
    
    var introView: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.ultraThinMaterial)
            VStack(alignment: .center) {
                Text("This new super-plant will be our hope to restore the earth.")
                    .font(.system(size: fontSize * 1.5, weight: .semibold, design: .monospaced))
                Image(systemName: "globe.americas.fill")
                    .font(.system(size: fontSize * 4))
                    .foregroundStyle(Color("GreenApple"))
                    .padding(.top, 30)
                    .symbolEffect(.breathe, options: .nonRepeating)
                
            }
            .frame(width: containerWidth * 0.95)
        }
        .frame(height: containerHeight * 0.8)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.black, lineWidth: 2)
        )
        .padding(.horizontal)
    }
    var namingView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.ultraThinMaterial)
            VStack(alignment: .leading) {
                logo
                Spacer()
                Text("Let's name your new plant")
                    .font(.system(size: fontSize * 1.5, weight: .semibold, design: .monospaced))
                    .padding(.bottom, 40)
                    .frame(maxWidth: containerWidth * 0.90, alignment: .center)
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.ultraThinMaterial)
                    TextField("Plant's name", text: $viewmodel.userPlant.customName)
                        .padding(10)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.black, lineWidth: 2)
                )
                .frame(width: containerWidth * 0.9, height: containerHeight * 0.06)
                
                if isNameNotEmpty {
                    Button{
                        continueToggle = true
                        withAnimation(.bouncy){
                            currentIndex = (currentIndex + 1) % scenes.count
                        }
                    } label: {
                        ZStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(.ultraThinMaterial)
                            Text("Continue")
                                .foregroundStyle(Color(uiColor: .label))
                                .padding(10)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.black, lineWidth: 2)
                        )
                        .padding(.top, 40)
                        .frame(width: containerWidth * 0.9, height: containerHeight * 0.06)
                    }
                }
                Spacer()
                Spacer()
            }
            .frame(width: containerWidth * 0.95)
        }
        .frame(height: containerHeight * 0.8)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke( viewmodel.userPlant.customName.isEmpty ? .black : Color("GreenApple"), lineWidth: 2)
            
        )
        .padding(.horizontal)
    }
    
    var cardStats: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.ultraThinMaterial)
            ScrollView(showsIndicators: false) {
                VStack {
                    plantImage
                        .padding(.bottom, 20)
                    Text(viewmodel.userPlant.customName)
                        .font(.system(size: fontSize * 1.5, weight: .semibold, design: .monospaced))
                        .padding(.bottom, 10)
                        .frame(maxWidth: containerWidth * 0.90, alignment: .center)
                    Text("A \(viewmodel.basePlant.name) modification")
                        .font(.system(size: fontSize, weight: .regular, design: .monospaced))
                        .padding(.bottom, 40)
                        .frame(maxWidth: containerWidth * 0.90, alignment: .center)
                    
                    genesList
                        .padding(.bottom, 20)
                    Text("Saves \(viewmodel.plantScore, specifier: "%.1f") kg of CO2 per year")
                        .font(.system(size: fontSize, design: .monospaced))
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                    Button{
                        withAnimation(.bouncy) {
                            currentIndex = (currentIndex + 1) % scenes.count
                        }
                    } label: {
                        ZStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(.ultraThinMaterial)
                            Text("Continue")
                                .padding(10)
                                .foregroundStyle(Color(uiColor: .label))
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.black, lineWidth: 2)
                        )
                        .padding(.top, 30)
                        .padding(.bottom, 70)
                        
                        .frame(width: containerWidth * 0.9, height: containerHeight * 0.06)
                    }
                    Spacer()
                }
            }
            .frame(width: containerWidth * 0.95)
        }
        .frame(height: containerHeight * 0.8)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.black, lineWidth: 2)
        )
        .padding(.horizontal)
    }
    
    var confirmView: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.ultraThinMaterial)
            VStack(alignment: .center) {
                logo
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Text("Your plant will face extreme conditions on Earth. Are you ready for the challenge?")
                    .font(.system(size: fontSize * 1.4, weight: .semibold, design: .monospaced))
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: fontSize * 4))
                    .foregroundStyle(Color("Citric").opacity(0.5))
                    .padding(.top, 30)
                    .symbolEffect(.bounce, options: .repeat(.continuous))
                Spacer()
                Button{
                    withAnimation(.bouncy) {
                        navigationPath.append("CardSorting")
                    }
                } label: {
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.ultraThinMaterial)
                        Text("Continue")
                            .padding(10)
                            .foregroundStyle(Color(uiColor: .label))
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.black, lineWidth: 2)
                    )
                    
                    .frame(width: containerWidth * 0.9, height: containerHeight * 0.06)
                }
                Spacer()
                
            }
            .frame(width: containerWidth * 0.95)
        }
        .frame(height: containerHeight * 0.8)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.black, lineWidth: 2)
        )
        .padding(.horizontal)
    }
    
    //MARK: Subviews components
    
    func plantResistances(_ resistances: [PlantAttributes]) -> some View {
         VStack(alignment: .leading){
            Text("Resistences")
                .font(.system(size: fontSize, design: .monospaced))
                .fontWeight(.regular)
                .padding(.bottom, 2)
            HStack{
                ForEach(resistances, id: \.rawValue) { resistance in
                    Image(systemName: resistance.icon)
                        .font(.system(size: 15))
                    Text(resistance.rawValue )
                        .font(.system(size: fontSize * 0.90, design: .monospaced))
                        .fontWeight(.regular)
                }
            }
        }
        
        
    }
    
    func plantWeaknesses(_ weaknesses: [PlantAttributes]) -> some View {
            VStack(alignment: .leading){
                Text("Weaknesses")
                    .font(.system(size: fontSize, design: .monospaced))
                    .fontWeight(.regular)
                HStack{
                    ForEach(weaknesses, id: \.rawValue) { weakness in
                        Image(systemName: weakness.icon)
                            .font(.system(size: 15))
                        Text(weakness.rawValue)
                            .font(.system(size: fontSize, design: .monospaced))
                            .fontWeight(.regular)
                    }
                }
            }
            .padding(.bottom, 2)
    }
    
    func co2saving(gene: Gene) -> some View {
        let savingMultiplier = String(format:"%.1fx CO2 saving multiplier", gene.CO2SavingMultiplier)
        return Text(gene.isCO2Saver ? savingMultiplier : "No CO2 saving")
            .font(.system(size: fontSize, design: .monospaced))
            .fontWeight(.bold)
    }
    
    var plantImage: some View {
        ZStack(alignment: .topTrailing) {
            Image(viewmodel.basePlant.imageName ?? "Default")
                .resizable()
                .scaledToFill()
                .frame(height: containerHeight * 0.30)
                .clipShape(.rect(topLeadingRadius: 12, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 12))
                .overlay(alignment: .bottom) {
                    LinearGradient(gradient: photoGradient, startPoint: .top, endPoint: .bottom)
                        .frame(height: 150)
                }
                .overlay{
                    UnevenRoundedRectangle(topLeadingRadius: 12, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 12)
                        .stroke(.black, lineWidth: 2)
                }
                .frame(maxWidth: .infinity)
            logo
                .foregroundStyle(.opacity(0.6))
        }
    }
    var genesList: some View {
        VStack(alignment: .leading) {
            ForEach(viewmodel.userPlant.getGenes()) { gene in
                ZStack {
                    HStack {
                        Image(systemName: gene.icon)
                            .font(.system(size: fontSize))
                            .fontWeight(.bold)
                            .frame(width: 50, height: 50)
                        VStack(alignment: .leading) {
                            Text(gene.name)
                                .font(.system(size: fontSize, design: .monospaced))
                                .fontWeight(.bold)
                            Text(gene.description)
                                .font(.system(size: fontSize * 0.90, design: .monospaced))
                                .lineLimit(3, reservesSpace: true)
                                .lineSpacing(1)
                                .padding(.bottom, 5)
                            
                            if let resistances = gene.resistance {
                                plantResistances(resistances)
                                    .padding(.bottom, 5)
                            } else {
                                Text("No resistences")
                                    .font(.system(size: fontSize, design: .monospaced))
                                    .fontWeight(.regular)
                                    .padding(.bottom, 5)
                            }
                            if let weaknesses = gene.weaknesses {
                                plantWeaknesses(weaknesses)
                                    .padding(.bottom, 5)
                            } else {
                                Text("No weaknesses")
                                    .font(.system(size: fontSize, design: .monospaced))
                                    .fontWeight(.regular)
                                    .padding(.bottom, 5)
                            }
                            Spacer()
                            
                            co2saving(gene: gene)
                        }
                    }
                    .padding(.vertical)
                }
                Rectangle().fill().frame(height: 1, alignment: .center)
            }
            
        }
        
    }
}
                                              
