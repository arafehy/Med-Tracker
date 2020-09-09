//
//  AppState.swift
//  Med Tracker
//
//  Created by Yazan Arafeh on 9/8/20.
//  Copyright © 2020 Yazan Arafeh. All rights reserved.
//

import Foundation

class MedState: ObservableObject {
    @Published var medicationGroups: [MedicationGroup] = []
    
    let dataManager: DataManager = DataManager()
    
    init() {
        self.medicationGroups = dataManager.retrieveMedications() ?? []
    }
    
    func addMedicationToGroup(newMed: MedicationItem, desiredGroup: MedicationGroup.TimeOfDay) {
        let desiredMedGroup = medicationGroups.filter { (group) -> Bool in
            group.timeOfDay == desiredGroup.rawValue
        }
        desiredMedGroup[0].medications.append(newMed)
        dataManager.storeMedications(medicationData: medicationGroups)
    }
    
    func deleteMedication(medToDelete: MedicationItem, locatedIn: MedicationGroup.TimeOfDay) {
        let medGroup = medicationGroups.filter { (group) -> Bool in
            group.timeOfDay == locatedIn.rawValue
        }
        guard let removeIndex = medGroup[0].medications.firstIndex(of: medToDelete) else {
            return
        }
        medGroup[0].medications.remove(at: removeIndex)
    }
}
