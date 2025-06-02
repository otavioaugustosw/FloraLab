//
//  CardARTip.swift
//  FloraLab
//
//  Created by Otávio Augusto on 15/02/25.
//

import SwiftUI
import TipKit

struct CardARTip: Tip {
    // tip that tells the user that they can view the plant in AR
    var title: Text {
        Text("See it in 3D!")
    }

    var message: Text? {
        Text("Click the 3D button to view the plant in AR")
    }

    var image: Image? {
        Image(systemName: "sparkle.magnifyingglass")
    }
}
