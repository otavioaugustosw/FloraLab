//
//  GeneCounter.swift
//  FloraLab
//
//  Created by Otávio Augusto on 18/02/25.
//

import SwiftUI

struct GeneCounter: View {
    private var isLandscape: Bool {
        UIScreen.main.bounds.height < 500 ? true : false
    }
    private var circleSize: CGFloat {
        isLandscape ? UIScreen.main.bounds.height * 0.12 : UIScreen.main.bounds.width * 0.12
    }
    private var fontSize: CGFloat {
        isLandscape ? UIScreen.main.bounds.width * 0.03 : UIScreen.main.bounds.height * 0.03
    }
    let userPlant: UserPlant?

    init(userPlant: UserPlant?) {
        self.userPlant = userPlant
    }

    var body: some View {
        let genes = userPlant?.getNewGenes() ?? []

        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.black.shadow(.inner(color: Color("BlueCode"), radius: 14)))
            
            HStack(spacing: 10) {
                if genes.count < 3 {
                    emptySlots(count: 3 - genes.count)
                }
                geneCircles(genes: genes)
            }
        }
        .shadow(color: Color("Nightime"), radius: 12)
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("Nightime").opacity(0.6), lineWidth: 2)
        )
    }
    
    // MARK: Subviews
    
    private func emptySlots(count: Int) -> some View {
        
        ForEach(0..<count, id: \.self) { _ in
            Circle()
                .stroke(Color("BlueCode"), lineWidth: 2)
                .frame(width: circleSize)
        }
    }

    private func geneCircles(genes: [Gene]) -> some View {
        ForEach(genes) { gene in
            Circle()
                .foregroundStyle(Color(gene.mainColor).shadow(.inner(color: .white, radius: 5)))
                .overlay {
                    Circle()
                        .stroke(Color("BlueCode"), lineWidth: 2)
                    Image(systemName: gene.icon)
                        .foregroundStyle(.white)
                        .font(.system(size: fontSize))
                        .fontWeight(.bold)
                }
                .frame(width: circleSize)
        }
    }
}

