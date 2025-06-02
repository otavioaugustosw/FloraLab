//
//  IntroView:.swift
//  FloraLab
//
//  Created by Otávio Augusto on 19/02/25.
//

import SwiftUI

struct IntroView: View {
    @StateObject private var motion =  MotionManager()
    @State private var currentIndex = 0
    @Binding var endIntro: Bool
    private let scenes: [GameLore] = GameLore.lore
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
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    
                    TabView(selection: $currentIndex) {
                        
                        ForEach(0..<scenes.count, id: \.self) { index in
                            VStack(alignment: .center) {
                                if index == scenes.count - 1 {
                                    storySlide(scenes[index])
                                        .padding(.bottom, 30)
                                    Button{
                                        withAnimation(.bouncy) {
                                            UserDefaults.standard.set(true, forKey: "hasSeenIntro")
                                            endIntro = true
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
                                        
                                        .frame(width: containerWidth * 0.95, height: containerHeight * 0.06)
                                        .padding(.bottom, 50)
                                    }
                                } else {
                                    storySlide(scenes[index])
                                }
                            }
                            .tag(index)
                        }
                    }
                    .frame(height: containerHeight * 0.95)
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
    
    func storySlide(_ lore: GameLore) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.ultraThinMaterial)
            VStack(alignment: .center) {
                ZStack(alignment: .topTrailing) {
                    Image(lore.image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: containerHeight * 0.4)
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
                }
                    .padding(.bottom, 20)
                Spacer()
                Text(lore.phrase)
                    .font(.system(size: fontSize * 1.3, design: .monospaced))
                    .fontWeight(.bold)
                    .padding(.bottom, 30)
                    .frame(width: containerWidth * 0.90)
                Spacer()
            }
        }
        .frame(width: containerWidth * 0.95, height: containerHeight * 0.80)
        .overlay{
            UnevenRoundedRectangle(topLeadingRadius: 12, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 12)
                .stroke(.black, lineWidth: 2)
        }
    }
}
                                              
                                            
