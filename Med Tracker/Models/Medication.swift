//
//  Medication.swift
//  Med Tracker
//
//  Created by Yazan Arafeh on 8/30/20.
//  Copyright © 2020 Yazan Arafeh. All rights reserved.
//

import Foundation

class MedicationGroup: Codable, Identifiable {
    var id: UUID
    var timeOfDay: TimeOfDay
    var medications: [MedicationItem]
    
    enum CodingKeys: CodingKey {
        case id
        case timeOfDay
        case medications
    }
    
    enum TimeOfDay: String, CaseIterable, Identifiable, Codable {
        case beforeBreakfast = "Before Breakfast"
        case withBreakfast = "With Breakfast"
        case afterBreakfast = "After Breakfast"
        case beforeSleep = "Before Sleep"
        case other = "Other"
        
        var id: String { self.rawValue }
    }
    
    init(id: UUID, timeOfDay: TimeOfDay, medications: [MedicationItem]) {
        self.id = id
        self.timeOfDay = timeOfDay
        self.medications = medications
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        timeOfDay = try container.decode(TimeOfDay.self, forKey: .timeOfDay)
        medications = try container.decode(Array<MedicationItem>.self, forKey: .medications)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(timeOfDay, forKey: .timeOfDay)
        try container.encode(medications, forKey: .medications)
    }
}

class MedicationItem: Codable, Equatable, Identifiable, ObservableObject {
    static func == (lhs: MedicationItem, rhs: MedicationItem) -> Bool {
        lhs.id == rhs.id
    }
    
    @Published var id: UUID
    @Published var name: String
    @Published var count: Int
    @Published var instructions: String
    @Published var lastTaken: Date
    
    var image: String {
        name
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case count
        case instructions
        case lastTaken
    }
    
    init(id: UUID, name: String, count: Int, instructions: String, lastTaken: Date) {
        self.id = id
        self.name = name
        self.count = count
        self.instructions = instructions
        self.lastTaken = lastTaken
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: CodingKeys.id)
        name = try container.decode(String.self, forKey: CodingKeys.name)
        count = try container.decode(Int.self, forKey: CodingKeys.count)
        instructions = try container.decode(String.self, forKey: CodingKeys.instructions)
        lastTaken = try container.decode(Date.self, forKey: CodingKeys.lastTaken)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: CodingKeys.id)
        try container.encode(name, forKey: CodingKeys.name)
        try container.encode(count, forKey: CodingKeys.count)
        try container.encode(instructions, forKey: CodingKeys.instructions)
    }
    
    #if DEBUG
    static let example = MedicationItem(id: UUID(), name: "Sinemet", count: 333, instructions: """
    • Take 4 times a day
    • Starting at 8 AM, then once every 4 hours
    """, lastTaken: Date())
    #endif
}
