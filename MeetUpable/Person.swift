//
//  Person.swift
//  MeetUpable
//
//  Created by Raymond Chen on 4/2/22.
//

import SwiftUI

struct Person: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    
    static let example = Person(id: UUID(), name: "John Smith")
    
    static func <(lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
    
    static func loadImage(person: Person) -> Image {
        let imagePath = FileManager.documentDirectory.appendingPathComponent("\(person.id.uuidString).jpg")
        if let data = try? Data(contentsOf: imagePath), let loaded = UIImage(data: data) {
            return Image(uiImage: loaded)
        }
        return Image(systemName: "person")
    }
}
