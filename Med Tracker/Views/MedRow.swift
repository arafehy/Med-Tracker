//
//  MedRow.swift
//  Med Tracker
//
//  Created by Yazan Arafeh on 9/1/20.
//  Copyright © 2020 Yazan Arafeh. All rights reserved.
//

import SwiftUI

struct MedRow: View {
    var medication: MedicationItem
    
    var body: some View {
        HStack {
            Image("\(medication.image)")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(medication.name)
                    .font(.headline)
                Text("Remaining: \(medication.count)")
            }
        }
    }
}

struct MedRow_Previews: PreviewProvider {
    static var previews: some View {
        MedRow(medication: MedicationItem.example)
    }
}
