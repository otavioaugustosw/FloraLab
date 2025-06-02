//
//  PlantsDetailView.swift
//  FloraLab
//
//  Created by Otávio Augusto on 16/02/25.
//

import SwiftUI

struct PlantsDetailView: View {
    private var isLandscape: Bool {
        UIScreen.main.bounds.height < 500 ? true : false
    }
    private var cardWSize: CGFloat {
        isLandscape ? UIScreen.main.bounds.height * 0.95 : UIScreen.main.bounds.width * 0.95
    }
    private var fontSize: CGFloat  {
        isLandscape ? UIScreen.main.bounds.height * 0.04 : UIScreen.main.bounds.width * 0.04
    }
    private var iconSize: CGFloat  = UIScreen.main.bounds.height * 0.03
    private var gradient = Gradient(colors: [Color("BlueCode"), Color("Nightime") ])
    private var wikiGradient = Gradient(colors: [Color("Resin"), .clear])

    let plant: BasePlant
    let userPlant: UserPlant?
    let genes: [Gene]
    let savingMultiplier: Double
    let forWiki: Bool
    init(plant: BasePlant, forWiki: Bool = false) {
        self.plant = plant
        self.genes = plant.geneKeys.map{Gene.getGene($0)}
        self.savingMultiplier = self.genes.map{$0.CO2SavingMultiplier}.reduce(1, *)
        self.forWiki = forWiki
        self.userPlant = nil
    }
    
    init(userPlant: UserPlant) {
        self.plant = BasePlant.getPlant(userPlant.originalPlantID)
        self.genes = userPlant.getGenes()
        self.savingMultiplier = userPlant.co2Multiplier
        self.forWiki = true
        self.userPlant = userPlant
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: forWiki ? wikiGradient : gradient, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()



            ScrollView(.vertical, showsIndicators: false) {
                 PlantsCard(plant: plant, hasARButton: true, forwiki: forWiki, userPlant: userPlant)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 35)


                
                VStack{
                    factsCard(title: "Region of origin", description: plant.regionOfOrigin)
                    factsCard(title: "Fun fact", description: plant.curiosity)
                }
                .padding(.horizontal, 10)
                
                ZStack {
                    genesCard
                }
                .frame(maxWidth: cardWSize)
                co2SavedInfo
                    .frame(maxWidth: cardWSize)

            }
        }

    }
    
    // MARK: Subviews
    
    func factsCard(title: String, description: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.thinMaterial)
            VStack(spacing: 10) {
                Text(title)
                    .font(.system(size: fontSize * 1.2, design: .monospaced))
                    .foregroundStyle(Color(uiColor: .label))
                    .fontWeight(.bold)
                Text(description)
                    .font(.system(size: fontSize * 0.90, design: .monospaced))
                    .foregroundStyle(Color(uiColor: .label))
                    .frame(width: cardWSize * 0.95, alignment: .leading)
            }
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.black, lineWidth: 2)
        )
        .padding(.bottom, 35)
    }
    
    var genesCard: some View {
        VStack(alignment: .leading) {
            ForEach(genes) { gene in
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.thinMaterial)
                    VStack {
                        if genes.first?.key == gene.key {
                            Text("Genes")
                                .font(.system(size: fontSize * 1.2, design: .monospaced))
                                .foregroundStyle(Color(uiColor: .label))
                                .fontWeight(.bold)
                                .padding(.top, 20)
                                .padding(.bottom, 10)
                        }
                        
                        HStack {
                            Image(systemName: gene.icon)
                                .foregroundStyle(Color(gene.mainColor))
                                .font(.system(size: isLandscape ? iconSize * 2.5 : iconSize ))
                                .fontWeight(.bold)
                                .frame(width: isLandscape ? 80 : 50, height: isLandscape ? 80 : 50)
                            plantInfo(gene: gene)
                        }
                        .padding(.vertical)
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.black, lineWidth: 2)
                )
            }
            
        }
    }
    
    var co2SavedInfo: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.regularMaterial)
            HStack(spacing: 10) {
                Image(systemName: "carbon.dioxide.cloud.fill")
                    .foregroundStyle(Color("GreenApple"))
                    .font(.system(size: iconSize))
                    .fontWeight(.bold)
                    .padding(.trailing, 10)
                
                Text("Saves \(plant.CO2SavedKg * savingMultiplier, specifier: "%.1f") kg of CO2 per year")
                    .font(.system(size: fontSize * 0.90, design: .monospaced))
                    .foregroundStyle(Color(uiColor: .label))
                    .fontWeight(.bold)
            }
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.black, lineWidth: 2)
        )
        .padding(.bottom, 50)
    }
    
    func plantInfo(gene: Gene) -> some View {
        VStack(alignment: .leading ,spacing: 10) {
            Text(gene.name)
                .font(.system(size: fontSize, design: .monospaced))
                .foregroundStyle(Color(uiColor: .label))
                .fontWeight(.bold)
            Text(gene.description)
                .font(.system(size: fontSize * 0.90, design: .monospaced))
                .lineLimit(3, reservesSpace: true)
                .lineSpacing(1)
                .foregroundStyle(Color(uiColor: .label))

            if let resistances = gene.resistance {
                VStack(alignment: .leading){
                    Text("Resistences")
                        .font(.system(size: fontSize, design: .monospaced))
                        .foregroundStyle(Color(uiColor: .label))
                        .fontWeight(.regular)
                        .padding(.bottom, 2)
                    HStack{
                        ForEach(resistances, id: \.rawValue) { resistance in
                            Image(systemName: resistance.icon)
                                .foregroundStyle(Color(uiColor: .label))
                                .font(.system(size: 15))
                            Text(resistance.rawValue )
                                .font(.system(size: fontSize * 0.90, design: .monospaced))
                                .foregroundStyle(Color(uiColor: .label))
                                .fontWeight(.regular)
                        }
                    }
                }
                
            } else {
                Text("No resistences")
                    .font(.system(size: fontSize, design: .monospaced))
                    .foregroundStyle(Color(uiColor: .label))
                    .fontWeight(.regular)
            }
            if let weaknesses = gene.weaknesses {
                VStack(alignment: .leading){
                    Text("Weaknesses")
                        .font(.system(size: fontSize, design: .monospaced))
                        .foregroundStyle(Color(uiColor: .label))
                        .fontWeight(.regular)
                    HStack{
                        ForEach(weaknesses, id: \.rawValue) { weaknesses in
                            Image(systemName: weaknesses.icon)
                                .foregroundStyle(Color(uiColor: .label))
                                .font(.system(size: 15))
                            Text(weaknesses.rawValue)
                                .font(.system(size: fontSize, design: .monospaced))
                                .foregroundStyle(Color(uiColor: .label))
                                .fontWeight(.regular)
                        }
                    }
                }
                .padding(.bottom, 2)
            } else {
                Text("No weaknesses")
                    .font(.system(size: fontSize, design: .monospaced))
                    .foregroundStyle(Color(uiColor: .label))
                    .fontWeight(.regular)
            }
            
            let savingMultiplier = String(format:"%.1fx CO2 saving multiplier", gene.CO2SavingMultiplier)
            Text(gene.isCO2Saver ? savingMultiplier : "No CO2 saving")
                .font(.system(size: fontSize, design: .monospaced))
                .foregroundStyle(Color(uiColor: .label))
                .fontWeight(.bold)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var user = {
        let plant = UserPlant(originalPlantID: BasePlant.getPlant("corn").id, customName: "Nice Plant")
        Gene.getAll().map{$0.key}.forEach{ plant.addNewGene($0)}
        return plant
    }()
    
    static var previews: some View {
        PlantsDetailView(userPlant: user)
            .previewDevice(PreviewDevice(rawValue: "iPhone 16 Pro"))
            .previewDisplayName("DETAIL USER")

        PlantsDetailView(plant: .getPlant("rose"))
            .previewDevice(PreviewDevice(rawValue: "iPhone 16 Pro"))
            .previewDisplayName("DETAIL BASE")
    }
}
