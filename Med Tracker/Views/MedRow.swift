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
            thumbnail
            VStack(alignment: .leading) {
                Text(medication.name)
                    .font(.headline)
                Text("Remaining: \(medication.count)")
            }
        }
    }
    
    var thumbnail: some View {
        Image("\(medication.image)")
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
    }
}

struct MedRow_Previews: PreviewProvider {
    static var previews: some View {
        MedRow(medication: MedicationItem.example)
    }
}
