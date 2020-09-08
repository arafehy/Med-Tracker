//
//  AddMed.swift
//  Med Tracker
//
//  Created by Yazan Arafeh on 9/1/20.
//  Copyright © 2020 Yazan Arafeh. All rights reserved.
//

import SwiftUI

struct AddMed: View {
    @Environment(\.presentationMode) var presentation
    
    @State private var name: String = ""
    @State private var count: String = ""
    @State private var instructions: String = ""
    @State private var medGroup = MedicationGroup.TimeOfDay.beforeBreakfast
    
    @ObservedObject var medications: Medications
    
//    MARK: - Form Validation
    
    private var allFieldsFilled: Bool {
        !name.isEmpty && !instructions.isEmpty && !count.isEmpty
    }
    private var someFieldsFilled: Bool {
        !name.isEmpty || !instructions.isEmpty || !count.isEmpty
    }
    
    @State private var showAddAlert: Bool = false
    @State private var showCancelAlert: Bool = false
    
    // MARK: - Views
    
    var body: some View {
        NavigationView {
            Form {
                medicationInfo
                Section(header: Text("Add an image")) {
                    HStack {
                        Spacer()
                        cameraButton
                        Spacer()
                    }
                }
                addMedicationButton
            }
            .navigationBarItems(leading: cancelButton)
            .navigationBarTitle("Add New Medication")
        }
    }
    
    var medicationInfo: some View {
        Section(header: Text("Medication Information")) {
            TextField("Medication Name", text: $name)
            TextField("Medication Count", text: $count)
                .keyboardType(.numberPad)
            TextField("Medication Instructions", text: $instructions)
            Picker("Taken:", selection: $medGroup) {
                Text(MedicationGroup.TimeOfDay.beforeBreakfast.rawValue).tag(MedicationGroup.TimeOfDay.beforeBreakfast)
                Text(MedicationGroup.TimeOfDay.withBreakfast.rawValue).tag(MedicationGroup.TimeOfDay.withBreakfast)
                Text(MedicationGroup.TimeOfDay.afterBreakfast.rawValue).tag(MedicationGroup.TimeOfDay.afterBreakfast)
                Text(MedicationGroup.TimeOfDay.beforeSleep.rawValue).tag(MedicationGroup.TimeOfDay.beforeSleep)
                Text(MedicationGroup.TimeOfDay.other.rawValue).tag(MedicationGroup.TimeOfDay.other)
            }
        }
    }
    
    //    MARK: - Buttons
    
    var addMedicationButton: some View {
        Button("Add Medication") {
            guard self.allFieldsFilled else {
                self.showAddAlert.toggle()
                return
            }
            guard let count = Int(self.count) else {
                self.showAddAlert.toggle()
                return
            }
            let newMed = MedicationItem(id: UUID(), name: self.name, count: count, instructions: self.instructions)
            self.addMedicationToGroup(newMed: newMed)
            self.presentation.wrappedValue.dismiss()
        }
        .alert(isPresented: $showAddAlert) { () -> Alert in
            Alert(title: Text("All fields except the image must be filled. Count must be a whole number."))
        }
    }
    
    var cameraButton: some View {
        Button(action: {
            print("Camera tapped")
        }) {
            Image(systemName: "camera")
                .font(.largeTitle)
        }.padding()
    }
    
    var cancelButton: some View {
        Button(action: {
            // TODO: Check if any fields have been entered
            self.presentation.wrappedValue.dismiss()
        }) {
            Text("Cancel")
        }
    }
    
    func addMedicationToGroup(newMed: MedicationItem) {
        let desiredMedGroup = medications.medicationGroups.filter { (group) -> Bool in
            group.name == self.medGroup.rawValue
        }
        desiredMedGroup[0].addMedication(newMed: newMed)
    }
}

struct AddMed_Previews: PreviewProvider {
    static var previews: some View {
        AddMed(medications: Medications())
    }
}
