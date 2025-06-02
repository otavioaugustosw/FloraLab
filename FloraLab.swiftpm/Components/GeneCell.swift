//
//  GeneCell.swift
//  FloraLab
//
//  Created by Otávio Augusto on 17/02/25.
//

import SwiftUI

struct GeneCell: View {
    private var isLandscape: Bool {
        UIScreen.main.bounds.height < 500 ? true : false
    }
    private var circleSize: CGFloat {
        isLandscape ? UIScreen.main.bounds.height * 0.13 : UIScreen.main.bounds.width * 0.13
    }
    private var fontSize: CGFloat {
        isLandscape ? UIScreen.main.bounds.width * 0.017 : UIScreen.main.bounds.height * 0.017
    }
    @State private var isSelected: Bool = false
    let userPlant: UserPlant?
    let gene: Gene

    init(gene: Gene, userPlant: UserPlant?) {
        self.gene = gene
        self.userPlant = userPlant
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(Color(gene.mainColor).opacity(0.1))
                }
            HStack {
                geneIcon
                geneInfo
                Spacer()
                selectionIndicator
            }
            .padding(14)
        }
        .onAppear { updateSelection() }
        .onChange(of: userPlant?.geneKeys) { updateSelection() }
    }
    
    // MARK: Subviews
    
    private var geneIcon: some View {
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

    private var geneInfo: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(gene.name)
                .font(.system(size: fontSize, design: .monospaced))
                .foregroundStyle(.black)
                .fontWeight(.regular)
            
            if let resistances = gene.resistance {
                VStack(alignment: .leading){
                    Text("Resistences")
                        .font(.system(size: fontSize, design: .monospaced))
                        .foregroundStyle(.black)
                        .fontWeight(.regular)
                    HStack{
                        ForEach(resistances, id: \.rawValue) { resistance in
                            Image(systemName: resistance.icon)
                                .foregroundStyle(.black)
                                .font(.system(size: 15))
                            Text(resistance.rawValue)
                                .font(.system(size: fontSize, design: .monospaced))
                                .foregroundStyle(.black)
                                .fontWeight(.regular)
                        }
                    }
                }
                .padding(.bottom, 2)
            } else {
                Text("No resistences")
                    .font(.system(size: fontSize, design: .monospaced))
                    .foregroundStyle(.black)
                    .fontWeight(.regular)
            }
            
            if let weaknesses = gene.weaknesses {
                VStack(alignment: .leading){
                    Text("Weaknesses")
                        .font(.system(size: fontSize, design: .monospaced))
                        .foregroundStyle(.black)
                        .fontWeight(.regular)
                    HStack{
                        ForEach(weaknesses, id: \.rawValue) { weaknesses in
                            Image(systemName: weaknesses.icon)
                                .foregroundStyle(.black)
                                .font(.system(size: 15))
                            Text(weaknesses.rawValue)
                                .font(.system(size: fontSize, design: .monospaced))
                                .foregroundStyle(.black)
                                .fontWeight(.regular)
                        }
                    }
                }
                .padding(.bottom, 2)
            } else {
                Text("No weaknesses")
                    .font(.system(size: fontSize, design: .monospaced))
                    .foregroundStyle(.black)
                    .fontWeight(.regular)
            }

            
            Text(gene.isCO2Saver ?
                 "\(gene.CO2SavingMultiplier, specifier: "%.1f")x CO2 saving multiplier" :
                 "No CO2 saving")
                .font(.system(size: fontSize * 0.90, design: .monospaced))
                .foregroundStyle(.black)
                .fontWeight(.bold)
        }
        .padding(.leading, 5)
    }

    private var selectionIndicator: some View {
        Circle()
            .stroke(.black, lineWidth: 2)
            .frame(width: circleSize * 0.50)
            .overlay {
                if isSelected {
                    Circle()
                        .foregroundStyle(Color(gene.mainColor).shadow(.inner(color: .white, radius: 5)))
                        .frame(width: circleSize * 0.30)
                }
            }
    }
    
    // MARK: Functions
    
    private func updateSelection() {
        guard let userPlant else { return }
        isSelected = userPlant.geneKeys.map{ Gene.getGene($0).id }.contains(gene.id)
    }
    
}


