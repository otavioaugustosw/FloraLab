//
//  File.swift
//  FloraLab
//
//  Created by Otávio Augusto on 20/02/25.
//

import Foundation

struct GameLore {
    let phrase: String
    let image: String
    
    static let lore: [GameLore] = [
        GameLore(
            phrase: "The Earth chokes on toxic air. Where rainforests once roared, now only silent smog remains.",
            image: "EarthToxic"
        ),
        GameLore(
            phrase: "Amidst the chaos, the Crazy Lab stands as a temple of forbidden science and discovery.",
            image: "CrazyLab"
        ),
        GameLore(
            phrase: "Combine DNA strands to create plants with incredible traits and discover the secrets of genetic science!",
            image: "DNA"
        ),
        GameLore(
            phrase: "But every alteration comes with risk. Fate awaits on a roulette of environmental trials.",
            image: "Roulette"
        ),
        GameLore(
            phrase: "Will your creation rise against scorching dust storms and other extreme conditions? The future of Earth depends on you.",
            image: "Final"
        )
    ]
}


