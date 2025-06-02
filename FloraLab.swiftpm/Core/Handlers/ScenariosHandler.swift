//
//  ScenariosHandler.swift
//  FloraLab
//
//  Created by Otávio Augusto on 20/02/25.
//

class ScenariosHandler {
    let scenarios = Scenario.scenarios
    var chosenScenario: Scenario? = nil
    
    func chooseRandomScenario() {
        chosenScenario = scenarios.randomElement() ?? Scenario.defaultScenario
    }
    
    func calculateWeaknessPenalties(for plantWeaknesses: [PlantAttributes], withScore score: Double) -> [PlantAttributes: Double] {
        guard let scenario = chosenScenario else { return [:] }
        var penalties: [PlantAttributes: Double] = [:]
        for weakness in plantWeaknesses {
            if let multiplier = scenario.appliedWeaknesses[weakness] {
                penalties[weakness] = multiplier * score
            }
        }
        return penalties
    }
    
    func evaluatePlantDetails(score: Double, plantResistances: [PlantAttributes], plantWeaknesses: [PlantAttributes]) -> (finalScore: Double, weaknessPenalties: [PlantAttributes: Double], missingResistances: [PlantAttributes]) {
        guard let scenario = chosenScenario else { return (score, [:], []) }
        
        let weaknessPenalties = calculateWeaknessPenalties(for: plantWeaknesses, withScore: score)
        let totalPenalty = weaknessPenalties.values.reduce(0, +)
        let finalScore = score - totalPenalty
        
        let missingResistances = scenario.resistancesNecessaryToWin.filter { !plantResistances.contains($0) }
        
        return (finalScore, weaknessPenalties, missingResistances)
    }
}


