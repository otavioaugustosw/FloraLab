//
//  Scenarios.swift
//  FloraLab
//
//  Created by Otávio Augusto on 20/02/25.
//

import Foundation

struct Scenario {
    let name: String
    let description: String
    let goodEndingImage: String
    let badEndingImage: String
    let goodEndingText: String
    let badEndingText: String
    let CO2NecessaryToWin: Double
    let resistancesNecessaryToWin: [PlantAttributes]
    let appliedWeaknesses: [PlantAttributes: Double]
    let weaknessFeedback: [PlantAttributes: String]
    let badEndingFeedbacks: [PlantAttributes: String]
}

