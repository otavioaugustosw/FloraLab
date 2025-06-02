//
//  GeneVisualizer.swift
//  FloraLab
//
//  Created by Otávio Augusto on 12/02/25.
//
import SwiftUI

struct GeneVisualizer: View {
    private var isLandscape: Bool {
        UIScreen.main.bounds.height < 500 ? true : false
    }
    private var circleSize: CGFloat {
        isLandscape ? UIScreen.main.bounds.height * 0.13 : UIScreen.main.bounds.width * 0.13
    }
    private var fontSize: CGFloat {
        isLandscape ? UIScreen.main.bounds.height * 0.05 : UIScreen.main.bounds.width * 0.05
    }
    private var containerWidth: CGFloat {
        isLandscape ? UIScreen.main.bounds.height * 0.95 : UIScreen.main.bounds.width * 0.95
    }
    private var containerHeight: CGFloat {
        isLandscape ? UIScreen.main.bounds.width * 0.90 : UIScreen.main.bounds.height * 0.90
    }
    @State private var isSelected: Bool = false
    @StateObject private var motion =  MotionManager()
    var gene: Gene?
    
    var body: some View {
        ZStack(alignment: .center) {
            if let gene {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.white)
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(Color(gene.mainColor).opacity(0.2).shadow(.inner(color: Color(gene.mainColor).opacity(0.7), radius: 12, x: motion.x * -3, y: motion.y * -3)))
                }
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.white.opacity(0.7).shadow(.inner(color: Color(gene?.mainColor ?? "Resin").opacity(0.7), radius: 12, x: motion.x * -3, y: motion.y * -3)))
            }
            
            if let gene {
                geneInfo(gene: gene)
                    .frame(width: containerWidth * 0.90, alignment: .leading)
            } else {
                Image(systemName: "waveform.path.ecg")
                    .foregroundStyle(Color("Resin"))
                    .font(.system(size: 60))
            }
        }
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.black, lineWidth: 2)
        )
        .rotation3DEffect(.degrees(motion.y * 4), axis: (x: -1, y: 0, z: 0))
        .rotation3DEffect(.degrees(motion.x * 4), axis: (x: 0, y: 1, z: 0))
    }
    
    private func geneInfo(gene: Gene) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(gene.name)
                .font(.system(size: fontSize, design: .monospaced))
                .foregroundStyle(.black)
                .fontWeight(.bold)
            Text(gene.description)
                .font(.system(size: fontSize, design: .monospaced))
                .foregroundStyle(.black)
                .fontWeight(.regular)
            if let resistances = gene.resistance {
                VStack(alignment: .leading){
                    Text("Resistences")
                        .font(.system(size: fontSize, design: .monospaced))
                        .foregroundStyle(.black)
                        .fontWeight(.bold)
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
                        .fontWeight(.bold)
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
    
    private func selectionIndicator(gene: Gene) -> some View {
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
    
}
