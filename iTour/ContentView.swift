//
//  ContentView.swift
//  iTour
//
//  Created by Furqan Ali on 3/17/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
//    @Query(sort: \Destination.priority, order: .reverse) var destinations: [Destination] ///  one example of sorting
    
//    @Query(sort: [SortDescriptor(\Destination.priority, order: .reverse), SortDescriptor(\Destination.name)]) var destinations: [Destination]
    // above is the 2nd way of sorting.
    // but the problem is that what if user wants to sort things up dynamically. then we will do the other approach.
    
    @Environment(\.modelContext) var modelContext
    @State private var path = [Destination]()
    
    @State private var sortOrder = SortDescriptor(\Destination.name)
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            DestinationListingView(sort: sortOrder, searchString: searchText)
            .navigationTitle("iTour")
            .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
            .searchable(text: $searchText)
            .toolbar {
                Button("Add Samples", action: addSamples)
                Button("Add destination", systemImage: "plus", action: addDestination)
                Menu("Sort", systemImage: "arrow.up.arrow.down"){
                    Picker("Sort", selection: $sortOrder) {
                        Text("Name").tag(SortDescriptor(\Destination.name))
                        Text("Priority").tag(SortDescriptor(\Destination.priority, order: .reverse))
                        Text("Date").tag(SortDescriptor(\Destination.date))
                    }
                    .pickerStyle(.inline)
                }
            }
            
        }
    }
    
    func addSamples() {
        let rome = Destination(name: "Rome")
        let florence = Destination(name: "Florence")
        let paris = Destination(name: "Paris")
        
        modelContext.insert(rome)
        modelContext.insert(florence)
        modelContext.insert(paris)
        
    }
    
    func addDestination() {
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination]
    }
    
    
    
}

#Preview {
    ContentView()
}
