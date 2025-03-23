//
//  Destination.swift
//  iTour
//
//  Created by Furqan Ali on 3/17/25.
//

import Foundation
import SwiftData

@Model
class Destination {
    var name: String
    var details: String
    var date: Date
    var priority: Int
    @Relationship(deleteRule: .cascade) var sights = [Sight]()
    // cascade means when I delete destination object, delete all it's sights too... like whatever is stored in Sight delete it. 
    
    init(name: String = "", details: String = "", date: Date = .now, priority: Int = 2) {
        self.name = name
        self.details = details
        self.date = date
        self.priority = priority
    }
}
