//
//  ScenariosCatalog.swift
//  FloraLab
//
//  Created by Otávio Augusto on 20/02/25.
//

extension Scenario {
    static let defaultScenario = Scenario(
        name: "Unknown",
        description: "",
        goodEndingImage: "Default",
        badEndingImage: "Default",
        goodEndingText: "",
        badEndingText: "",
        CO2NecessaryToWin: 28,
        resistancesNecessaryToWin:[],
        appliedWeaknesses: [:],
        weaknessFeedback: [:],
        badEndingFeedbacks: [
            .disease: "",
            .heat: ""
        ]
    )
    
    static let scenarios: [Scenario] = [
        Scenario(
            name: "Abandoned Metropolis",
            description: "Once a thriving urban center, now abandoned and choked by industrial decay. Pollution and urban heat dominate the landscape.",
            goodEndingImage: "UrbanGood",
            badEndingImage: "UrbanBad",
            goodEndingText: "Your super plant has reclaimed the concrete jungle, purifying the air and reviving nature.",
            badEndingText: "Without proper defenses, urban pathogens and intense heat decimated your creation.",
            CO2NecessaryToWin: 28,
            resistancesNecessaryToWin: [.disease, .heat],
            appliedWeaknesses: [.flood: 0.30],
            weaknessFeedback: [.flood: "Unexpected flash floods weakened your plant's structure."],
            badEndingFeedbacks: [
                .disease: "Without disease resistance, urban pathogens decimated your creation.",
                .heat: "Extreme urban heat scorched your plant's cells."
            ]
        ),
        Scenario(
            name: "Acidic Downpour",
            description: "Acid rain falls relentlessly over scorched land, corroding soil and water sources.",
            goodEndingImage: "AcidGood",
            badEndingImage: "AcidBad",
            goodEndingText: "Your plant stands resilient, neutralizing the acid and renewing the earth.",
            badEndingText: "The corrosive downpour eroded your plant's defenses, leaving it lifeless.",
            CO2NecessaryToWin: 30,
            resistancesNecessaryToWin: [.flood, .disease],
            appliedWeaknesses: [.drought: 0.35],
            weaknessFeedback: [.drought: "Dry conditions intensified the corrosive effects of acid rain."],
            badEndingFeedbacks: [
                .flood: "The acid floodwaters washed away your plant.",
                .disease: "Deadly pathogens thrived in the acidic environment, wiping out your plant."
            ]
        ),
        Scenario(
            name: "Radioactive Wasteland",
            description: "Decades after nuclear fallout, radiation contaminates the land, mutating life and fostering deadly pathogens.",
            goodEndingImage: "RadGood",
            badEndingImage: "RadBad",
            goodEndingText: "Your engineered plant not only survives the radiation but thrives, purifying the wasteland.",
            badEndingText: "Without adequate defenses, radiation-induced mutations proved fatal.",
            CO2NecessaryToWin: 32,
            resistancesNecessaryToWin: [.disease],
            appliedWeaknesses: [.cold: 0.40],
            weaknessFeedback: [.cold: "The biting cold in irradiated nights froze your plant's progress."],
            badEndingFeedbacks: [
                .disease: "Without disease resistance, radiation-induced mutations proved fatal."
            ]
        ),
        Scenario(
            name: "Toxic Swamp",
            description: "A vast, dark swamp choked with chemical runoff and decay, where toxic waters threaten all life.",
            goodEndingImage: "SwampGood",
            badEndingImage: "SwampBad",
            goodEndingText: "Your plant purifies the swamp, turning poison into nourishment and restoring balance.",
            badEndingText: "The toxic environment overwhelmed your plant, leaving the swamp barren.",
            CO2NecessaryToWin: 26,
            resistancesNecessaryToWin: [.flood, .disease],
            appliedWeaknesses: [.heat: 0.30],
            weaknessFeedback: [.heat: "Intense heat accelerated toxic reactions, compromising your plant's stability."],
            badEndingFeedbacks: [
                .flood: "The swamp's relentless waters drowned your plant.",
                .disease: "Contagions in the swamp decimated your plant's defenses."
            ]
        ),
        Scenario(
            name: "Volcanic Fury",
            description: "Raging volcanoes spew ash and toxic gases, scorching the land and leaving barren soil in their wake.",
            goodEndingImage: "LavaGood",
            badEndingImage: "LavaBad",
            goodEndingText: "Your super plant channels volcanic fury, filtering toxic ash and transforming devastation into renewal.",
            badEndingText: "Without the proper adaptations, the volcanic wrath reduced your creation to mere ash.",
            CO2NecessaryToWin: 24,
            resistancesNecessaryToWin: [.heat, .drought],
            appliedWeaknesses: [.disease: 0.50],
            weaknessFeedback: [.disease: "Volcanic ash fosters opportunistic pathogens that cripple your plant."],
            badEndingFeedbacks: [
                .heat: "Scorching volcanic heat incinerated your plant.",
                .drought: "The parched, ash-covered soil failed to nurture your plant."
            ]
        )
    ]
    
    
}
