//
//  GeneCapsule.swift
//  FloraLab
//
//  Created by Otávio Augusto on 18/02/25.
//
import SwiftUI

struct GeneCapsule: View {
    private var isLandscape: Bool {
        UIScreen.main.bounds.height < 500 ? true : false
    }
    private var fontSize: CGFloat {
        isLandscape ? UIScreen.main.bounds.width * 0.017 : UIScreen.main.bounds.height * 0.017
    }
    let text: String
    let icon: String?
    
    init(text: String, icon: String? = nil) {
        self.icon = icon
        self.text = text
    }
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.black.shadow(.inner(color: Color("BlueCode"),radius: 14)))
            HStack(spacing: 10) {
                
                if let icon {
                    Image(systemName: icon)
                        .foregroundStyle(Color("BlueCode"))
                        .font(.system(size: fontSize))
                        .fontWeight(.bold)
                        .padding(.trailing, 10)
                }
                
                Text(text)
                    .font(.system(size: fontSize, design: .monospaced))
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
            }
        }
        .shadow(color: Color("Nightime"), radius: 12)
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("Nightime").opacity(0.4), lineWidth: 2)
        )
    }
}

