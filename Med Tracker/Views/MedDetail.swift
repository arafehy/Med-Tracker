//
//  MedDetail.swift
//  Med Tracker
//
//  Created by Yazan Arafeh on 9/1/20.
//  Copyright © 2020 Yazan Arafeh. All rights reserved.
//

import SwiftUI

struct MedDetail: View {
    @State var medication: MedicationItem
    
    var showImage: Bool {
        guard let _ = UIImage(named: "\(medication.image)") else {
            return false
        }
        return true
    }
    
    var body: some View {
        VStack {
            if showImage {
                medImage
            }
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
        HStack {
            subtractButton
            Text("Remaining: \(medication.count)")
                .font(.largeTitle)
                .bold()
            addButton
        }
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
    
//    MARK: - Buttons
    
    var addButton: some View {
        Button(action: {
            self.medication.count += 1
        }){
            Image(systemName: "plus.square")
                .font(.title)
                .accentColor(.green)
        }
    }
    
    var subtractButton: some View {
        Button(action: {
            self.medication.count -= 1
        }){
            Image(systemName: "minus.square")
                .font(.title)
                .accentColor(.red)
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
