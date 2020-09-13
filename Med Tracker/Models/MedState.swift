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
        guard let desiredMedGroupIndex = medicationGroups.firstIndex(where: { $0.timeOfDay == desiredGroup }) else { return }
        medicationGroups[desiredMedGroupIndex].medications.append(newMed)
        dataManager.storeMedications(medicationData: medicationGroups)
    }
    
    func deleteMedications(at offsets: IndexSet, in group: MedicationGroup) {
        guard let desiredMedGroupIndex = medicationGroups.firstIndex(where: { $0.timeOfDay == group.timeOfDay }) else { return }
        medicationGroups[desiredMedGroupIndex].medications.remove(atOffsets: offsets)
        dataManager.storeMedications(medicationData: medicationGroups)
    }
}
