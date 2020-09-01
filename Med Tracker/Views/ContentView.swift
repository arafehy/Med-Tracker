//
//  ContentView.swift
//  Med Tracker
//
//  Created by Yazan Arafeh on 9/1/20.
//  Copyright © 2020 Yazan Arafeh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var medications = Bundle.main.decode([MedsByTimeOfDay].self, from: "medications.json")
    
    var body: some View {
        NavigationView {
            List {
                ForEach(medications) { timeOfDay in
                    Section(header: Text(timeOfDay.name)) {
                        ForEach(timeOfDay.medications) { medication in
                            Text(medication.name)
                        }
                    }
                }
            }
        }.listStyle(GroupedListStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
