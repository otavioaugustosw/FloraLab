//
//  PlantResistance.swift
//  FloraLab
//
//  Created by Otávio Augusto on 19/02/25.
//


enum PlantAttributes: String, CaseIterable {
    case heat = "Heat"
    case cold = "Cold"
    case drought = "Drought"
    case flood = "Flood"
    case pests = "Pests"
    case disease = "Disease"
    
    var icon: String {
        switch self {
        case .heat: return "sun.max.fill"
        case .cold: return "snowflake"
        case .drought: return "drop.triangle.fill"
        case .flood: return "waveform.path.ecg"
        case .pests: return "ant.fill"
        case .disease: return "cross.fill"
        }
    }
}
