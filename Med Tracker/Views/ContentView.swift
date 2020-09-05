//
//  ContentView.swift
//  Med Tracker
//
//  Created by Yazan Arafeh on 9/1/20.
//  Copyright © 2020 Yazan Arafeh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var dataManager: DataManager = DataManager()
    var medications: [MedicationGroup] {
        dataManager.medications
    }
    
    @State var displayAddModal = false
    
    var body: some View {
        NavigationView {
            medList
                .navigationBarTitle("Medications")
                .navigationBarItems(trailing: addButton)
        }
        .sheet(isPresented: $displayAddModal) {
            AddMed()
        }
    }
    
    var medList: some View {
        List {
            ForEach(medications) { timeOfDay in
                Section(header: Text(timeOfDay.name)) {
                    ForEach(timeOfDay.medications) { medication in
                        MedRow(medication: medication)
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
        ContentView()
    }
}
