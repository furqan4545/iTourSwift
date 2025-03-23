////
////  DestinationListingView.swift
////  iTour
////
////  Created by Furqan Ali on 3/23/25.
////
///
/// This is one way of working with sorting..
//
//import SwiftUI
//import SwiftData
//
//struct DestinationListingView: View {
//    
//    @Query(sort: [SortDescriptor(\Destination.priority, order: .reverse), SortDescriptor(\Destination.name)]) var destinations: [Destination]
//    
//    @Environment(\.modelContext) var modelContext
//    
//    var body: some View {
//        
//        List {
//            ForEach(destinations) {destination in
//                NavigationLink(value: destination) {
//                    VStack(alignment: .leading){
//                        Text(destination.name)
//                            .font(.headline)
//                        Text(destination.date.formatted(date: .long, time: .shortened))
//                    }
//                }
//                
//                .contextMenu {
//                    Button("Delete", role: .destructive) {
//                        // Figure out this item's index, then call your deleteDestinations method
//                        if let index = destinations.firstIndex(where: { $0.id == destination.id }) {
//                            deleteDestinations(IndexSet(integer: index))
//                        }
//                    }
//                }
//            }
//            .onDelete(perform: deleteDestinations)
//        }
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//    
//    init(sort: SortDescriptor<Destination>) {
//        _destinations = Query(sort: [sort])
//    }
//    
//    func deleteDestinations(_ indexSet: IndexSet){
//        for index in indexSet {
//            let destination = destinations[index]
//            modelContext.delete(destination)
//        }
//    }
//}
//
//#Preview {
//    DestinationListingView(sort: SortDescriptor(\Destination.name))
//}


//
//  DestinationListingView.swift
//  iTour
//
//  Created by Furqan Ali on 3/23/25.
//

////  this is for implementing searching filter.

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
    }
    
//    init(sort: SortDescriptor<Destination>) {
//        _destinations = Query( filter: #Predicate {
//            $0.priority >= 2
//        }, sort: [sort])
//    }
    
////    or
//    init(sort: SortDescriptor<Destination>) {
//        let now = Date.now
//        _destinations = Query( filter: #Predicate {
//            $0.date > now
//        }, sort: [sort])
//    }
//    OR 
    init(sort: SortDescriptor<Destination>, searchString: String) {
        _destinations = Query( filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                return $0.name.localizedStandardContains(searchString) // localizedStandardContains checks for letter and takes care of all searching filters and logic.
            }
        }, sort: [sort])
    }
    
    func deleteDestinations(_ indexSet: IndexSet){
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
}

#Preview {
    DestinationListingView(sort: SortDescriptor(\Destination.name), searchString: "")
}
