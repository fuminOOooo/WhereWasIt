//
//  Nano2App.swift
//  Nano2
//
//  Created by Elvis Susanto on 25/05/23.
//

import SwiftUI

@main
struct Nano2App: App {
    
    @StateObject private var coreDataStack = CoreDataStack.shared

    var body: some Scene {
        
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, coreDataStack.persistentContainer.viewContext)
        }
        
    }
}
