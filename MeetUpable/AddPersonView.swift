//
//  AddPersonView.swift
//  MeetUpable
//
//  Created by Raymond Chen on 4/2/22.
//

import CoreImage
import SwiftUI

struct AddPersonView: View {
    @Environment(\.dismiss) var dismiss
    var onSave: (Person, UIImage?) -> Void
    
    @State private var name: String = ""
    @State private var inputImage: UIImage?
    @State private var image: Image?
    @State private var showingImagePicker = false
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(.secondary)
                Text("Tap to select a picture")
                    .opacity(image == nil ? 1 : 0)
                image?
                    .resizable()
                    .scaledToFit()
            }
            .onTapGesture {
                showingImagePicker = true
            }
        }
        .onChange(of: inputImage) { _ in loadImage() }
        Form {
            Section {
                TextField("Name of person", text: $name)
                Button("Save") {
                    let newPerson = Person(id: UUID(), name: name)
                    onSave(newPerson, inputImage)
                    dismiss()
                }
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        image = Image(uiImage: inputImage)
    }
    
}

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView() { newPerson, newImage in }
    }
}
