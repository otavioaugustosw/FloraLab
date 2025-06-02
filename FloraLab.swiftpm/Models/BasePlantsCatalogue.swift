//
//  BasePlants.swift
//  FloraLab
//
//  Created by Otávio Augusto on 16/02/25.
//


extension BasePlant {
    static let defaultPlant = BasePlant(id: "Unknown", name: "Unknown", description: "The plant selected was not found", CO2SavedKg: 0, geneKeys: [], curiosity: "", regionOfOrigin: "")

    private static let allBasePlant: [String:BasePlant] = [
        
    "cactus": BasePlant(
        id: "cactus",
        name: "Cactus",
        description: "A resilient desert plant with specialized adaptations to minimize water loss.",
        CO2SavedKg: 10,
        geneKeys: ["cactusSpines", "cactusWaterStorage"],
        modelName: "Cactus.usdz",
        imageName: "cactus",
        curiosity: "Some cactus species can store water in their thick stems, allowing them to survive up to two years without rain.",
        regionOfOrigin: "Americas (native to arid regions from the Sonoran Desert to the Andean Highlands)"
    ),

    "corn": BasePlant(
        id: "corn",
        name: "Corn",
        description: "A high-yield crop known for its versatility, drought tolerance, and rapid growth.",
        CO2SavedKg: 8,
        geneKeys: ["cornDroughtTolerance", "cornFastGrowth"],
        modelName: "Corn.usdz",
        imageName: "corn",
        curiosity: "Despite dramatic changes in appearance from its wild ancestor teosinte, modern corn and teosinte both have 20 chromosomes.",
        regionOfOrigin: "Mesoamerica (Central Mexico)"
    ),

    "sakura": BasePlant(
        id: "sakura",
        name: "Sakura",
        description: "A delicate flowering tree admired for its beautiful blossoms and cultural significance.",
        CO2SavedKg: 12,
        geneKeys: ["sakuraTempResilience", "sakuraSymbiosis"],
        modelName: "Sakura.usdz",
        imageName: "sakura",
        curiosity: "Sakura blossoms are celebrated in Japan for their fleeting beauty and symbolize the transient nature of life.",
        regionOfOrigin: "East Asia (Japanese Archipelago)"
    ),

    "rose": BasePlant(
        id: "rose",
        name: "Rose",
        description: "A beautifully scented flower with a balance between attracting pollinators and promoting growth in neighboring plants.", CO2SavedKg: 7,
        geneKeys: ["roseScentStrength", "roseThornless"],
        modelName: "Rose.usdz",
        imageName: "rose",
        curiosity: "Fossil records suggest that roses have been around for at least 35 million years, attesting to their ancient lineage.",
        regionOfOrigin: "Northern Hemisphere (originating in Asia Minor)"
    ),

    "sunflower": BasePlant(
        id: "sunflower",
        name: "Sunflower",
        description: "A vibrant plant known for its striking appearance and dynamic sun tracking behavior.",
        CO2SavedKg: 8,
        geneKeys: ["sunflowerPhototropism", "sunflowerSeedYield"],
        modelName: "Sunflower.usdz",
        imageName: "sunflower",
        curiosity: "Each sunflower head can contain up to 2,000 individual florets arranged in elegant Fibonacci spirals.",
        regionOfOrigin: "North America (primarily native to the Great Plains)"
    ),
    ]
    
    static func getPlant(_ key: String) -> BasePlant {
        allBasePlant[key, default: .defaultPlant]
    }
    
    static func getAll3D() -> [BasePlant] {
         allBasePlant.values.filter{ $0.modelName != nil }
    }
    
    static func getAll(except: [String] = []) -> [BasePlant] {
         allBasePlant.values.filter{ !except.contains($0.id) }
    }
}



