//
//  iTourApp.swift
//  iTour
//
//  Created by Furqan Ali on 3/17/25.
//

import SwiftUI
import SwiftData

@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self) // this will wrap the whole app with persistent container. 
    }
}
