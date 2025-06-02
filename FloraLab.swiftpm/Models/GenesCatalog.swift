//
//  GenesCatalog.swift
//  FloraLab
//
//  Created by Otávio Augusto on 16/02/25.
//

import Foundation



extension Gene {
    private static let allGenes: [String: Gene] = [
        "cactusSpines": Gene(
            name: "Desert Armor",
            key: "cactusSpines",
            description: "Thick spines that reduce water loss, increasing CO₂ absorption efficiency in arid conditions.",
            resistance: [.heat, .pests],
            weaknesses: [.cold],
            icon: "exclamationmark.triangle",
            mainColor: "GreenApple",
            isCO2Saver: true,
            CO2SavingMultiplier: 1.5
        ),

        "cactusWaterStorage": Gene(
            name: "Aqua Core",
            key: "cactusWaterStorage",
            description: "Stores water for extended photosynthesis during droughts.",
            resistance: [.drought, .heat],
            weaknesses: [.disease],
            icon: "drop.fill",
            mainColor: "BlueCode",
            isCO2Saver: true,
            CO2SavingMultiplier: 1.2
        ),

        "cornDroughtTolerance": Gene(
            name: "Root Resilience",
            key: "cornDroughtTolerance",
            description: "Deep roots to access groundwater, sustaining CO₂ capture in dry seasons.",
            resistance: [.drought],
            weaknesses: [.flood],
            icon: "arrow.down.heart",
            mainColor: "Cinnamon",
            isCO2Saver: true,
            CO2SavingMultiplier: 1.4
        ),

        "cornFastGrowth": Gene(
            name: "Rapid Cobs",
            key: "cornFastGrowth",
            description: "Accelerates growth rate to maximize CO₂ intake during short growing seasons.",
            resistance: nil,
            weaknesses: [.pests, .heat],
            icon: "bolt",
            mainColor: "Sun",
            isCO2Saver: true,
            CO2SavingMultiplier: 1.4
        ),

        "roseScentStrength": Gene(
            name: "Floral Fog",
            key: "roseScentStrength",
            description: "Strong fragrance attracts pollinators, enhancing ecosystem CO₂ balance.",
            resistance: [.pests],
            weaknesses: [.drought],
            icon: "sparkles",
            mainColor: "OtavioGarden",
            isCO2Saver: true,
            CO2SavingMultiplier: 1.5
        ),

        "roseThornless": Gene(
            name: "Sleek Stems",
            key: "roseThornless",
            description: "Thorn-free stems let nearby plants thrive, indirectly boosting CO₂ absorption.",
            resistance: nil,
            weaknesses: [.flood],
            icon: "scissors",
            mainColor: "Foxy",
            isCO2Saver: true,
            CO2SavingMultiplier: 1.5
        ),

        "sakuraTempResilience": Gene(
            name: "Petal Frostguard",
            key: "sakuraTempResilience",
            description: "Tolerates temperature swings for year-round CO₂ absorption.",
            resistance: [.cold],
            weaknesses: [.heat],
            icon: "thermometer.snowflake",
            mainColor: "ColdBreeze",
            isCO2Saver: false,
            CO2SavingMultiplier: 1.0
        ),

        "sakuraSymbiosis": Gene(
            name: "Nitrogen Network",
            key: "sakuraSymbiosis",
            description: "Partners with soil microbes to amplify CO₂-to-biomass conversion.",
            resistance: [.disease],
            weaknesses: [.heat],
            icon: "atom",
            mainColor: "Nightime",
            isCO2Saver: true,
            CO2SavingMultiplier: 1.25
        ),

        "sunflowerPhototropism": Gene(
            name: "Solar Seeker",
            key: "sunflowerPhototropism",
            description: "Dynamic leaf alignment maximizes sunlight-to-CO₂ conversion.",
            resistance: [.heat],
            weaknesses: [.cold],
            icon: "sun.max",
            mainColor: "Citric",
            isCO2Saver: true,
            CO2SavingMultiplier: 1.5
        ),

        "sunflowerSeedYield": Gene(
            name: "Seed Spire",
            key: "sunflowerSeedYield",
            description: "High-yield seeds store carbon long-term.",
            resistance: nil,
            weaknesses: [.drought],
            icon: "leaf.fill",
            mainColor: "Mint",
            isCO2Saver: true,
            CO2SavingMultiplier: 1.5
        ),

        "mangroveWaterFiltration": Gene(
            name: "Aqua Purifier",
            key: "mangroveWaterFiltration",
            description: "Roots adapted to filter excess water, allowing survival in flood-prone areas.",
            resistance: [.flood],
            weaknesses: [.drought],
            icon: "waveform.path",
            mainColor: "BlueCode",
            isCO2Saver: true,
            CO2SavingMultiplier: 1.3
        ),

        "tundraAntifreeze": Gene(
            name: "Ice Shield",
            key: "tundraAntifreeze",
            description: "Produces natural antifreeze compounds, preventing cell damage in freezing temperatures.",
            resistance: [.cold],
            weaknesses: [.heat],
            icon: "thermometer.snowflake",
            mainColor: "ColdBreeze",
            isCO2Saver: true,
            CO2SavingMultiplier: 1.2
        ),

        "rainforestLeafExpansion": Gene(
            name: "Broad Canopy",
            key: "rainforestLeafExpansion",
            description: "Large leaves increase photosynthesis efficiency, enhancing CO₂ capture.",
            resistance: nil,
            weaknesses: [.cold],
            icon: "leaf.arrow.circlepath",
            mainColor: "GreenApple",
            isCO2Saver: true,
            CO2SavingMultiplier: 1.6
        ),

        "vineRapidGrowth": Gene(
            name: "Climbing Vine",
            key: "vineRapidGrowth",
            description: "Fast-growing stems allow plants to reach sunlight quickly in competitive environments.",
            resistance: nil,
            weaknesses: [.cold],
            icon: "arrow.up.right.circle",
            mainColor: "Cinnamon",
            isCO2Saver: true,
            CO2SavingMultiplier: 1.5
        ),

        "fungalSymbiosis": Gene(
            name: "Mycorrhizal Web",
            key: "fungalSymbiosis",
            description: "Forms symbiotic relationships with fungi, enhancing nutrient absorption and CO₂ fixation.",
            resistance: [.disease],
            weaknesses: [.heat],
            icon: "network",
            mainColor: "Cinnamon",
            isCO2Saver: true,
            CO2SavingMultiplier: 1.4
        ),

        "thornDefense": Gene(
            name: "Defensive Spikes",
            key: "thornDefense",
            description: "Sharp thorns deter herbivores, reducing pest damage and promoting healthy growth.",
            resistance: [.pests],
            weaknesses: [.drought],
            icon: "exclamationmark.shield",
            mainColor: "Resin",
            isCO2Saver: true,
            CO2SavingMultiplier: 1.25
        ),

        "saltTolerance": Gene(
            name: "Salt Excretion",
            key: "saltTolerance",
            description: "Specialized cells excrete excess salt, allowing survival in coastal and saline environments.",
            resistance: [.flood],
            weaknesses: [.drought],
            icon: "bolt.horizontal",
            mainColor: "Mint",
            isCO2Saver: true,
            CO2SavingMultiplier: 1.3
        ),

        "bioluminescentLure": Gene(
            name: "Glow Attraction",
            key: "bioluminescentLure",
            description: "Emits a faint bioluminescent glow at night, attracting pollinators and supporting ecosystem stability.",
            resistance: nil,
            weaknesses: [.cold],
            icon: "lightbulb.fill",
            mainColor: "Radioactive",
            isCO2Saver: true,
            CO2SavingMultiplier: 1.7
        ),

        "resinHealing": Gene(
            name: "Resin Regeneration",
            key: "resinHealing",
            description: "Produces resin to seal wounds, preventing infections and improving disease resistance.",
            resistance: [.disease],
            weaknesses: [.pests],
            icon: "bandage.fill",
            mainColor: "Citric",
            isCO2Saver: true,
            CO2SavingMultiplier: 1.3
        )
        ]
    
    static func getGene(_ key: String) -> Gene {
        allGenes[key, default: Gene(name: "Unknown", key: "Unknown", description: "The gene selected was not found", icon: "exclamationmark.triangle.fill", mainColor: "Citrus", isCO2Saver: false, CO2SavingMultiplier: 1)]
    }
    
    static func getAll(except: [String] = []) -> [Gene] {
        allGenes.values.filter{ !except.contains($0.key) }
    }
}
