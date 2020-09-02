//
//  MedDetail.swift
//  Med Tracker
//
//  Created by Yazan Arafeh on 9/1/20.
//  Copyright © 2020 Yazan Arafeh. All rights reserved.
//

import SwiftUI

struct MedDetail: View {
    var medication: MedicationItem
    
    var body: some View {
        VStack {
            medImage
            medCount
            medInstructions
            Spacer()
        }
        .navigationBarTitle(Text(medication.name))
    }
    
    var medImage: some View {
        Image(medication.image)
            .resizable()
            .scaledToFit()
    }
    
    var medCount: some View {
        Text("Remaining: \(medication.count)")
            .font(.largeTitle)
            .bold()
    }
    
    var medInstructions: some View {
        VStack {
            Text("Instructions")
                .font(.title)
                .padding(.top)
            HStack {
                Text(medication.instructions)
                    .padding(.horizontal)
                Spacer()
            }
        }
    }
}

struct MedDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MedDetail(medication: MedicationItem.example)
        }
    }
}
