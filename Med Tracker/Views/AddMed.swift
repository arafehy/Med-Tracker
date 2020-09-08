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
            VStack {
                Spacer()
                cameraButton
                Spacer()
                medicationInfo
                addMedicationButton
                Spacer()
            }.padding()
                .navigationBarTitle("Add New Medication")
        }
    }
    
    var medicationInfo: some View {
        VStack {
            TextField("Medication Name", text: $name)
            TextField("Count", text: $count)
                .keyboardType(.numberPad)
            TextField("Instructions", text: $instructions)
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
        AddMed()
    }
}
