//
//  ContentView.swift
//  MeetUpable
//
//  Created by Raymond Chen on 4/2/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: ViewModel

    init() {
        self._viewModel = StateObject(wrappedValue: ViewModel())
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.people) { person in
                    NavigationLink {
                        Text("Placeholder for \(person.name)")
                    } label : {
                        HStack {
                            viewModel.loadImage(person: person)
                                .resizable()
                                .frame(width:44, height: 44)
                            Text(person.name)
                                .font(.headline)
                        }
                    }
                }
                .onDelete { indexSet in
                    viewModel.deletePerson(at: indexSet)
                }
            }
            .navigationTitle("MeetUpable")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.showingAddScreen.toggle()
                    } label: {
                        Label("Add Person", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $viewModel.showingAddScreen) {
                AddPersonView() { newPerson, newImage in
                    viewModel.add(person: newPerson, image: newImage)
                }
            }
        }
        
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
