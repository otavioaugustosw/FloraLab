//
//  ScoreCalculator.swift
//  FloraLab
//
//  Created by Otávio Augusto on 19/02/25.
//


class ScoreCalculator {
    func calculateScore(for plant: UserPlant) -> Double {
        return plant.co2Multiplier * plant.getBasePlant().CO2SavedKg
    }

}
