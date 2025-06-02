//
//  ScoreVisualizer.swift
//  FloraLab
//
//  Created by Otávio Augusto on 12/02/25.
//

import SwiftUI

struct ScoreVisualizer: View {
    private let fontSize = UIScreen.main.bounds.width * 0.05
    @Binding var score: Double

    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.black, lineWidth: 2)
                )
            HStack(alignment: .center) {

                if score <= 0 {
                    Image(systemName: "atom")
                        .font(.system(size: 30))
                        .symbolEffect(.bounce)
                        .foregroundStyle(Color("BlueCode"))

                              
                    Text("First, create a super-plant!")
                        .font(.system(.callout, design: .monospaced))
                        .fontWeight(.bold)
                        .lineLimit(1)
                } else {
                    Image(systemName: "carbon.dioxide.cloud.fill")
                        .font(.system(size: 30))
                        .foregroundStyle(Color("BlueCode"))
                    Text("\(score, specifier: "%.2f")kg of CO2 saved")
                        .font(.system(.title3, design: .monospaced))
                        .fontWeight(.bold)
                        .lineLimit(1)
                }

            }
        }
        .frame(maxWidth: .infinity)
    }
}
