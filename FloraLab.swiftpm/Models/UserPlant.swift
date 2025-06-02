//
//  Plants.swift
//  FloraLab
//
//  Created by Otávio Augusto on 15/02/25.
//
import Foundation
import SwiftData

@Model
final class UserPlant {
    var id: UUID = UUID()
    var customName: String
    var originalPlantID: String
    var geneKeys: [String]
    var co2Multiplier: Double {
         geneKeys.map{ Gene.getGene($0).CO2SavingMultiplier }.reduce(1.0, *)
     }
    
    init(originalPlantID: String, customName: String) {
        self.originalPlantID = originalPlantID
        self.customName = customName
        self.geneKeys = BasePlant.getPlant(originalPlantID).geneKeys
    }

}

extension UserPlant {
            
    func addNewGene(_ gene: String) {
        if !geneKeys.contains(gene){
            geneKeys.append(gene)
        }
    }
    
    func removeGene(_ gene: String) {
        if geneKeys.contains(gene){
            geneKeys.remove(at: geneKeys.firstIndex(of: gene)!)
        }
    }
    
    func getNewGenes() -> [Gene] {
        let baseGenes = getBasePlant().geneKeys
        return geneKeys.filter{ !baseGenes.contains($0) }.map{ Gene.getGene($0) }
    }
    
    func getGenes() -> [Gene] {
        geneKeys.map{ Gene.getGene($0) }
    }
    
    func getBasePlant() -> BasePlant {
        BasePlant.getPlant(originalPlantID)
    }
    
}

