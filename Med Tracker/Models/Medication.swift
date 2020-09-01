//
//  Medication.swift
//  Med Tracker
//
//  Created by Yazan Arafeh on 8/30/20.
//  Copyright © 2020 Yazan Arafeh. All rights reserved.
//

import Foundation

struct MedicationTimeOfDay: Codable, Identifiable {
    var id: UUID
    var name: String
    var medications: [MedicationItem]
}

struct MedicationItem: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var count: Int
    var instructions: String
    
    var image: String {
        name
    }
    
    #if DEBUG
    static let example = MedicationItem(id: UUID(), name: "Sinemet", count: 333, instructions: """
    • Take 4 times a day
    • Starting at 8 AM, then once every 4 hours
    """)
    #endif
}
