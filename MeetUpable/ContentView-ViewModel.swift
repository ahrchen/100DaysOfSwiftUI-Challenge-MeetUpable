//
//  ContentView-ViewModel.swift
//  MeetUpable
//
//  Created by Raymond Chen on 4/3/22.
//

import SwiftUI

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var people: [Person]
        
        @Published var showingAddScreen = false
        
        let savePath = FileManager.documentDirectory.appendingPathComponent("SavedPeople")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                people = try JSONDecoder().decode([Person].self, from: data)
            } catch {
                people = []
            }
        }
        
        func save(person: Person, image: UIImage?) {
            people.append(person)
            do {
                let data = try JSONEncoder().encode(people)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save people data")
            }
            
            let imageSavePath = FileManager.documentDirectory.appendingPathComponent("\(person.id.uuidString).jpg")
            
            if let jpegData = image?.jpegData(compressionQuality: 0.8) {
                try? jpegData.write(to: imageSavePath, options: [.atomic, .completeFileProtection])
            }
        }
    }
}
