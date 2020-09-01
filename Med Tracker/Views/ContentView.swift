//
//  ContentView.swift
//  Med Tracker
//
//  Created by Yazan Arafeh on 9/1/20.
//  Copyright © 2020 Yazan Arafeh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var displayAddModal = false
    
    let medications = Bundle.main.decode([MedsByTimeOfDay].self, from: "medications.json")
    
    var body: some View {
        NavigationView {
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
            .navigationBarTitle("Medications")
            .navigationBarItems(trailing: addButton)
        }
        .sheet(isPresented: $displayAddModal) {
            AddMed()
        }
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
