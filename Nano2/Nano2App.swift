//
//  Nano2App.swift
//  Nano2
//
//  Created by Elvis Susanto on 25/05/23.
//

import SwiftUI

@main
struct Nano2App: App {
    
//    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NewMainView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
