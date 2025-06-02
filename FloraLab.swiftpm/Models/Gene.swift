//
//  Genes.swift
//  FloraLab
//
//  Created by Otávio Augusto on 15/02/25.
//
import Foundation
import SwiftData

struct Gene: Identifiable {
    var id: UUID = UUID()
    var name: String
    var key: String
    var description: String
    var resistance: [PlantAttributes]?
    var weaknesses: [PlantAttributes]?
    var icon: String
    var mainColor: String
    var isCO2Saver: Bool
    var CO2SavingMultiplier: Double
}
