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
    
    @StateObject private var viewModel: ViewModel
    
    init(onSave: @escaping (Person, UIImage?) -> Void) {
        _viewModel = StateObject(wrappedValue: ViewModel())
        self.onSave = onSave
    }
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(.secondary)
                Text("Tap to select a picture")
                    .opacity(viewModel.image == nil ? 1 : 0)
                viewModel.image?
                    .resizable()
                    .scaledToFit()
            }
            .onTapGesture {
                viewModel.showingImagePicker = true
            }
        }
        .onChange(of: viewModel.inputImage) { _ in viewModel.loadImage() }
        Form {
            Section {
                TextField("Name of person", text: $viewModel.name)
                Button("Save") {
                    let newPerson = Person(id: UUID(), name: viewModel.name)
                    onSave(newPerson, viewModel.inputImage)
                    dismiss()
                }
            }
        }
        .sheet(isPresented: $viewModel.showingImagePicker) {
            ImagePicker(image: $viewModel.inputImage)
        }
    }
    
    
    
}

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView() { newPerson, newImage in }
    }
}
