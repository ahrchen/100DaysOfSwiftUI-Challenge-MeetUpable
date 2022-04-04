//
//  DetailView-ViewModel.swift
//  MeetUpable
//
//  Created by Raymond Chen on 4/3/22.
//

import SwiftUI

extension DetailView {
    @MainActor class ViewModel: ObservableObject {
        @Published var person: Person
        @Published var name: String
        @Published var image: Image
        
        @MainActor init(person: Person) {
            self.person = person
            self.name = person.name
            self.image = Person.loadImage(person: person)
        }
    }
}

