//
//  MainView.swift
//  FloraLab
//
//  Created by Otávio Augusto on 20/02/25.
//

import SwiftUI

struct MainView: View {
    @State var hasSeenIntro =  UserDefaults.standard.bool(forKey: "hasSeenIntro")
    @State var endIntro: Bool = false 
    
    var body: some View {
        if hasSeenIntro || endIntro {
            HomeView()
        } else {
            IntroView(endIntro: $endIntro)
        }
    }
}

#Preview {
    MainView()
}
