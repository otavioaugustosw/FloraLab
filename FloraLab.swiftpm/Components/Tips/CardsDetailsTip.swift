//
//  CardInfoTip.swift
//  FloraLab
//
//  Created by Otávio Augusto on 15/02/25.
//

import SwiftUI
import TipKit

struct CardsDetailsTip: Tip {
    // tip that tells the user that they can know more about the card they're viewing
    var title: Text {
        Text("Know more about the card")
    }

    var message: Text? {
        Text("Click the card and see the genes the plant contains and their benefits!")
    }

    var image: Image? {
        Image(systemName: "sparkle.magnifyingglass")
    }
}
