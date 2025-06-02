//
//  PlantViewModel`.swift
//  FloraLab
//
//  Created by Otávio Augusto on 18/02/25.
//

import SwiftUI

class PlantViewModel: ObservableObject {
    private let scoreCalculator = ScoreCalculator()
    private let scenariosHandler = ScenariosHandler()
    
    @Published var weaknessPenalties = [PlantAttributes: Double]()
    @Published var missingResistances = [PlantAttributes]()
    @Published var finalScore = 0.0
    @Published var plantScenario: Scenario = Scenario.defaultScenario
    @Published var availableGenes = [Gene]()
    @Published var userPlant: UserPlant
    @Published var basePlant: BasePlant
    var plantScore: Double {
        scoreCalculator.calculateScore(for: userPlant)
    }

    init(basePlant: BasePlant) {
        self.userPlant = UserPlant(originalPlantID: basePlant.id, customName: "Untitled")
        self.availableGenes = Gene.getAll(except: basePlant.geneKeys)
        self.basePlant = basePlant
    }
    
    func toggleGene(_ gene: Gene) {
        if userPlant.geneKeys.contains(gene.key) {
            withAnimation(.bouncy) {
                userPlant.removeGene(gene.key)
            }
        } else if userPlant.geneKeys.count < 5 {
            withAnimation(.bouncy) {
                userPlant.addNewGene(gene.key)
            }
        }
    }
    
    func updatePlant(_ newPlant: BasePlant) {
        basePlant = newPlant
        userPlant.originalPlantID = newPlant.id
        userPlant.geneKeys = newPlant.geneKeys
        withAnimation(.bouncy) {
            availableGenes = Gene.getAll(except: basePlant.geneKeys)
        }
    }
    
    func getResistences() -> [PlantAttributes] {
        let genes = userPlant.getGenes()
        return genes.map{$0.resistance}.compactMap{$0}.flatMap{$0}
    }
    
    func getWeaknesses() -> [PlantAttributes] {
        let genes = userPlant.getGenes()
        return genes.map{$0.weaknesses}.compactMap{$0}.flatMap{$0}
    }
    
    func chooseScenario() {
        scenariosHandler.chooseRandomScenario()
    }
    
    func setGameResult() {
        chooseScenario()
        plantScenario = scenariosHandler.chosenScenario ?? Scenario.defaultScenario
        let result = scenariosHandler.evaluatePlantDetails(score: plantScore, plantResistances: getResistences(), plantWeaknesses: getWeaknesses())
        finalScore = result.finalScore
        weaknessPenalties = result.weaknessPenalties
        missingResistances = result.missingResistances
    }
    
    func reset() {
        weaknessPenalties = [:]
        missingResistances = []
        finalScore = 0.0
        plantScenario = Scenario.defaultScenario
        availableGenes = []
        userPlant = UserPlant(originalPlantID: BasePlant.defaultPlant.id, customName: "Untitled")
        basePlant = BasePlant.defaultPlant
    }
}


