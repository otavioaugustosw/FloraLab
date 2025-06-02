
//
//  Score.swift
//  FloraLab
//
//  Created by Otávio Augusto on 18/02/25.
//

import SwiftUI

struct Capsule: View {
    private var width: CGFloat
    private var height: CGFloat
    let geometry: GeometryProxy
    let text: String
    let icon: String?
    let color: Color?
    
    init(geometry: GeometryProxy, text: String, icon: String? = nil, color: Color? = nil) {
        
        self.geometry = geometry
        self.width = geometry.size.width
        self.height = geometry.size.height
        self.icon = icon
        self.text = text
        self.color = color
    }
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(Color("Rain"))
            HStack(spacing: 10) {
                if let icon, let color {
                    Image(systemName: icon)
                        .foregroundStyle(color)
                        .font(.system(size: height*0.04))
                        .fontWeight(.bold)
                        .padding(.trailing, 10)
                }
                Text(text)
                    .font(.system(size: width * 0.04, design: .monospaced))
                    .foregroundStyle(.black)
                    .fontWeight(.bold)
                    .padding(.vertical)
            }
        }
        .frame(width: width*0.95)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.black, lineWidth: 2)
        )
    }
}
