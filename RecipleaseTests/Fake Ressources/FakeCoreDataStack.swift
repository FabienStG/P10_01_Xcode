//
//  FakeCoreDataStack.swift
//  RecipleaseTests
//
//  Created by Fabien Saint Germain on 28/11/2021.
//

import Foundation
import CoreData
import Reciplease
//
// MARK: - FakeCoreDataStack
//

/// Manage the way to save the data in the test cases by using the memory
class FakeCoreDataStack: CoreDataStack {
    //
    // MARK: - Initialization
    //
    override init() {
        super.init()
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(name: CoreDataStack.modelName, managedObjectModel: CoreDataStack.model)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        
        container.loadPersistentStores {_, error in
            if let error = error as NSError? {
                fatalError("Unresolves error \(error), \(error.userInfo)")
            }
        }
        
        storeContainer = container
    }
}
