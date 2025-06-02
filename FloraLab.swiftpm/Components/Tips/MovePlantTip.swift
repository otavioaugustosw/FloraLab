//
//  movePlantTip.swift
//  FloraLab
//
//  Created by Otávio Augusto on 15/02/25.
//

import SwiftUI
import TipKit

struct movePlantTip: Tip {
    // tip that tells the user that they can move around the plant in the visualizer
    var title: Text {
        Text("See the plant in every angle")
    }

    var message: Text? {
        Text("See the plant in 3D by moving around the 3D model in the visualizer")
    }


    var image: Image? {
        Image(systemName: "move.3d")
    }
}
