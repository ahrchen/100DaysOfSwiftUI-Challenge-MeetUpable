//
//  AddPersonView-ViewModel.swift
//  MeetUpable
//
//  Created by Raymond Chen on 4/3/22.
//

import SwiftUI

extension AddPersonView {
    @MainActor class ViewModel: ObservableObject {
        @Published var name: String = ""
        @Published var inputImage: UIImage?
        @Published var image: Image?
        @Published var showingImagePicker = false
        
        func loadImage() {
            guard let inputImage = inputImage else {
                return
            }
            image = Image(uiImage: inputImage)
        }
    }
}
