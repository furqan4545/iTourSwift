//
//  DestinationListingView.swift
//  iTour
//
//  Created by Furqan Ali on 3/23/25.
//

import SwiftUI
import SwiftData

struct DestinationListingView: View {
    
    @Query(sort: [SortDescriptor(\Destination.priority, order: .reverse), SortDescriptor(\Destination.name)]) var destinations: [Destination]
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        
        List {
            ForEach(destinations) {destination in
                NavigationLink(value: destination) {
                    VStack(alignment: .leading){
                        Text(destination.name)
                            .font(.headline)
                        Text(destination.date.formatted(date: .long, time: .shortened))
                    }
                }
                
                .contextMenu {
                    Button("Delete", role: .destructive) {
                        // Figure out this item's index, then call your deleteDestinations method
                        if let index = destinations.firstIndex(where: { $0.id == destination.id }) {
                            deleteDestinations(IndexSet(integer: index))
                        }
                    }
                }
            }
            .onDelete(perform: deleteDestinations)
        }
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    init(sort: SortDescriptor<Destination>) {
        _destinations = Query(sort: [sort])
    }
    
    func deleteDestinations(_ indexSet: IndexSet){
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
}

#Preview {
    DestinationListingView(sort: SortDescriptor(\Destination.name))
}
