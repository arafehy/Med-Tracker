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
                Spacer()
            }.padding()
                .navigationBarTitle("Add New Medication")
        }
    }
    
    var medicationInfo: some View {
        Section(header: Text("Medication Information")) {
            TextField("Medication Name", text: $name)
            TextField("Medication Count", text: $count)
                .keyboardType(.numberPad)
            TextField("Instructions", text: $instructions)
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
            self.presentation.wrappedValue.dismiss()
        }
    }
    
    var cameraButton: some View {
        Button(action: {
            print("Camera tapped")
        }) {
            Image(systemName: "camera")
                .font(.system(size: 100))
        }
    }
}

struct AddMed_Previews: PreviewProvider {
    static var previews: some View {
        AddMed(medications: Medications())
    }
}
