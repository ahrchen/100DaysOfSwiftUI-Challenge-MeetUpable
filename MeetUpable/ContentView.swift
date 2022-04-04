//
//  ContentView.swift
//  MeetUpable
//
//  Created by Raymond Chen on 4/2/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(viewModel.people.count)")
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
            }
            .sheet(isPresented: $viewModel.showingAddScreen) {
                AddPersonView() { newPerson, newImage in
                    viewModel.save(person: newPerson, image: newImage)
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
