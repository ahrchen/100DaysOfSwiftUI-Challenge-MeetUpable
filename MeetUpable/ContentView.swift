//
//  ContentView.swift
//  MeetUpable
//
//  Created by Raymond Chen on 4/2/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, world!")
                    .padding()
            }
            .navigationTitle("MeetUpable")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Person", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddPersonView()
            }
        }
        
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
