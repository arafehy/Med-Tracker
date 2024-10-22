//
//  ContentView.swift
//  Med Tracker
//
//  Created by Yazan Arafeh on 9/1/20.
//  Copyright © 2020 Yazan Arafeh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var medications: MedState
    
    @State var displayAddModal = false
    
    var body: some View {
        NavigationView {
            medList
                .navigationBarTitle("Medications")
                .navigationBarItems(leading: EditButton(), trailing: addButton)
        }
        .sheet(isPresented: $displayAddModal) {
            AddMed().environmentObject(self.medications)
        }
    }
    
    var medList: some View {
        List {
            ForEach(medications.medicationGroups) { (group: MedicationGroup) in
                Section(header: Text(group.timeOfDay.rawValue)) {
                    ForEach(group.medications) { (medication: MedicationItem) in
                        MedRow(medication: medication)
                    }
                    .onDelete {
                        self.medications.deleteMedications(at: $0, in: group)
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
    }
    
    var addButton: some View {
        Button(action: {
            self.displayAddModal.toggle()
        }){
            Image(systemName: "plus.circle.fill")
                .font(.title)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(MedState())
    }
}
