//
//  DataManager.swift
//  Med Tracker
//
//  Created by Yazan Arafeh on 9/3/20.
//  Copyright © 2020 Yazan Arafeh. All rights reserved.
//

import Foundation

class DataManager {
    
    var medFilePath: URL {
        getDocumentsDirectory().appendingPathComponent(Keys.dataFile.rawValue)
    }
    enum Keys: String {
        case dataFile = "MedData.plist"
    }
    
    func storeMedications(medicationData: Medications) {
        do {
            let data = try JSONEncoder().encode(medicationData)
            let medsJSON = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: true)
            try medsJSON.write(to: self.medFilePath)
            print("Successful save")
        } catch {
            print("Save Failed: ", error.localizedDescription)
        }
    }
    
    func retrieveMedications() -> Medications? {
        do {
            print("Retrieving")
            let data = try Data(contentsOf: self.medFilePath)
            guard let unarchivedData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Data else { return nil }
            return try JSONDecoder().decode(Medications.self, from: unarchivedData)
        }
        catch {
            print("Couldn't retrieve medications: ", error.localizedDescription)
            return resetMedFile()
        }
    }
    
    func resetMedFile() -> Medications? {
        guard let fileURL = Bundle.main.url(forResource: "medications", withExtension: "json") else {
            return nil
        }
        
        do {
            print("Resetting")
            let medsJSON = try Data(contentsOf: fileURL)
            let data = try NSKeyedArchiver.archivedData(withRootObject: medsJSON, requiringSecureCoding: true)
            try data.write(to: self.medFilePath)
            guard let readData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Data else {
                print("Could not read data")
                return nil
            }
            return try JSONDecoder().decode(Medications.self, from: readData)
        }
        catch {
            print("Failed to store sample file: ", error.localizedDescription)
            return nil
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
