//
//  DetailView.swift
//  MeetUpable
//
//  Created by Raymond Chen on 4/3/22.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject private var viewModel: ViewModel
    
    init(person: Person) {
        self._viewModel = StateObject(wrappedValue: ViewModel(person: person))
    }
    
    var body: some View {
        VStack {
            viewModel.image
                .resizable()
                .scaledToFit()
            Text(viewModel.name)
                .font(.title)
            Spacer()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(person: Person.example)
    }
}
