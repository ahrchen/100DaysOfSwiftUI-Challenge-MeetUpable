//
//  Person.swift
//  MeetUpable
//
//  Created by Raymond Chen on 4/2/22.
//

import Foundation
import UIKit

struct Person: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    
    static let example = Person(id: UUID(), name: "John Smith")
    
    static func <(lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
}
