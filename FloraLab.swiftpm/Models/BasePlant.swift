//
//  BasePlantTemplate.swift
//  FloraLab
//
//  Created by Otávio Augusto on 17/02/25.
//


struct BasePlant: Identifiable, Hashable {
    let id: String
    let name: String
    let description: String
    let CO2SavedKg: Double
    let geneKeys: [String]
    let modelName: String?
    let imageName: String?
    let curiosity: String
    let regionOfOrigin: String
    
    init(id: String, name: String, description: String, CO2SavedKg: Double, geneKeys: [String], modelName: String? = nil, imageName: String? = nil, curiosity: String, regionOfOrigin: String) {
        self.id = id
        self.name = name
        self.description = description
        self.CO2SavedKg = CO2SavedKg
        self.geneKeys = geneKeys
        self.modelName = modelName
        self.imageName = imageName
        self.curiosity = curiosity
        self.regionOfOrigin = regionOfOrigin
    }
}
