//
//  Medication.swift
//  Med Tracker
//
//  Created by Yazan Arafeh on 8/30/20.
//  Copyright © 2020 Yazan Arafeh. All rights reserved.
//

import Foundation

class Medications: Codable, ObservableObject {
    @Published var medicationGroups: [MedicationGroup]
    
    init() {
        let dataManager = DataManager()
        guard let medications = dataManager.retrieveMedications() else {
            self.medicationGroups = []
            return
        }
        self.medicationGroups = medications.medicationGroups
    }
    
    init(medicationGroups: [MedicationGroup]) {
        self.medicationGroups = medicationGroups
    }
    
    required init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var elements: [MedicationGroup] = []
        while !container.isAtEnd {
            do {
                let value = try container.decode(MedicationGroup.self)
                elements.append(value)
            } catch {
                print("Could not decode: ", error)
            }
        }
        self.medicationGroups = elements
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        for medGroup in medicationGroups {
            do {
                try container.encode(medGroup)
            }
            catch {
                print("Could not encode: ", error)
            }
        }
    }
}

class MedicationGroup: Codable, Identifiable {
    var id: UUID
    var name: String = ""
    var timeOfDay: String = ""
    var medications: [MedicationItem]
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case medications
    }
    
    enum TimeOfDay: String {
        case beforeBreakfast = "Before Breakfast"
        case withBreakfast = "With Breakfast"
        case afterBreakfast = "After Breakfast"
        case beforeSleep = "Before Sleep"
        case other = "Other"
    }
    
    init(id: UUID, name: String, timeOfDay: String, medications: [MedicationItem]) {
        self.id = id
        self.name = name
        self.timeOfDay = timeOfDay
        self.medications = medications
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        medications = try container.decode(Array<MedicationItem>.self, forKey: .medications)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(medications, forKey: .medications)
    }
    
    func addMedication(newMed: MedicationItem) {
        medications.append(newMed)
    }
}

class MedicationItem: Codable, Equatable, Identifiable {
    static func == (lhs: MedicationItem, rhs: MedicationItem) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: UUID
    var name: String
    var count: Int
    var instructions: String
    
    var image: String {
        name
    }
    
    init(id: UUID, name: String, count: Int, instructions: String) {
        self.id = id
        self.name = name
        self.count = count
        self.instructions = instructions
    }
    
    #if DEBUG
    static let example = MedicationItem(id: UUID(), name: "Sinemet", count: 333, instructions: """
    • Take 4 times a day
    • Starting at 8 AM, then once every 4 hours
    """)
    #endif
}
