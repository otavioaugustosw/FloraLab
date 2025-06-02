//
//  CardARTip.swift
//  FloraLab
//
//  Created by Otávio Augusto on 15/02/25.
//

import SwiftUI
import TipKit

struct DeletePlantTip: Tip {
    // tip that tells the user that they can delete their saved plant
    var title: Text {
        Text("Delete plants")
    }

    var message: Text? {
        Text("Press and hold on the card, then tap Delete to remove the plant from your save file.")
    }

    var image: Image? {
        Image(systemName: "trash.fill")
    }
}
