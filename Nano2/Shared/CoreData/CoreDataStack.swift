//
//  CoreDataStack.swift
//  Nano2
//
//  Created by Elvis Susanto on 20/12/24.
//

import CoreData
import UIKit

class CoreDataStack: ObservableObject {
    
    static let shared = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: CoreDataKeyConstant.dataModelName)
        
        container.loadPersistentStores { _, error in
            if let error {
                fatalError(StringConstant.persistentStoreLoadingFailure + StringConstant.dash + error.localizedDescription)
            }
        }
        return container
    }()
        
    private init() { }
}

extension CoreDataStack {
    
    func save() {
        
        guard persistentContainer.viewContext.hasChanges else { return }
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print(StringConstant.failedSave, error.localizedDescription)
        }
        
    }
    
    func delete(item: LocationItem) {
        
        persistentContainer.viewContext.delete(item)
        
        save()
        
    }
    
}
