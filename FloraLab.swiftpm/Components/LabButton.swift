//
//  SquareButton.swift
//  FloraLab
//
//  Created by Otávio Augusto on 12/02/25.
//

import SwiftUI

struct LabButton: View {
    private let fontSize = UIScreen.main.bounds.width * 0.05
    let title: String
    let mainColor: Color
    let icon: String
    let design: Font.Design
    let border: Bool
    
    init(
        title: String = "Title",
        mainColor: Color = .blue,
        icon: String = "tree.fill",
        design: Font.Design = .default,
        border: Bool = false
    ) {
        self.title = title
        self.mainColor = mainColor
        self.icon = icon
        self.design = design
        self.border = border
    }
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.regularMaterial)
                .preferredColorScheme(.light)
            
            VStack(alignment: .leading, spacing: 10) {
                Image(systemName: icon)
                    .font(.system(size: 30))
                    .foregroundStyle(mainColor)
                    .frame(height: 45)
                Text(title)
                    .font(.callout)
                    .fontDesign(design)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(uiColor: .label))
                    .multilineTextAlignment(.leading)
                    .lineLimit(1, reservesSpace: true)
            }
            .padding(.leading, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.black, lineWidth: border ? 2 : 0)
        )
    }
}
