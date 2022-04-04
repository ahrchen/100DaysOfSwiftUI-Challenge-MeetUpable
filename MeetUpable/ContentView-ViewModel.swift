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
        
        @MainActor init() {
            do {
                let data = try Data(contentsOf: savePath)
                people = try JSONDecoder().decode([Person].self, from: data)
            } catch {
                people = []
            }
        }
        
        func savePeople() {
            do {
                let data = try JSONEncoder().encode(people)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save people data")
            }
        }
        
        func add(person: Person, image: UIImage?) {
            people.append(person)
            savePeople()
            
            let imageSavePath = FileManager.documentDirectory.appendingPathComponent("\(person.id.uuidString).jpg")
            if let jpegData = image?.jpegData(compressionQuality: 0.8) {
                try? jpegData.write(to: imageSavePath, options: [.atomic, .completeFileProtection])
            }
        }
        
        func deletePerson(at offsets: IndexSet) {
            for offset in offsets {
                deleteImage(person: people[offset])
            }
            people.remove(atOffsets: offsets)
            savePeople()
        }
        
        func deleteImage(person: Person) {
            let fileManager = FileManager.default
            let imagePath = FileManager.documentDirectory.appendingPathComponent("\(person.id.uuidString).jpg")
            do {
                try fileManager.removeItem(at: imagePath)
            } catch {
                print("An error took place: \(error)")
            }
        }
    }
}
