//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Fabien Saint Germain on 25/11/2021.
//

import Foundation
import CoreData
//
// MARK: - CoreDataStack
//

/// Open Class CoreDataStack
/// The class manage the context and allowed to create storeContainer for the test.
/// It manage the saving of the data asynchrone
open class CoreDataStack {
    //
    // MARK: - Constants
    //
    public static let modelName = "Reciplease"

    public static let model: NSManagedObjectModel = {
      // swiftlint:disable force_unwrapping
      let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
      return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    // swiftlint:enable force_unwrapping

    //
    // MARK: - Initialization
    //
    public init() {
    }

    //
    // MARK: - Properties and Variables
    //
    public lazy var mainContext: NSManagedObjectContext = {
      return self.storeContainer.viewContext
    }()

    public lazy var storeContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: CoreDataStack.modelName, managedObjectModel: CoreDataStack.model)
      container.loadPersistentStores { _, error in
        if let error = error as NSError? {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      }
      return container
    }()

    //
    // MARK: - Internal Methods
    //
    public func newDerivedContext() -> NSManagedObjectContext {
      let context = storeContainer.newBackgroundContext()
      return context
    }

    public func saveContext() {
      saveContext(mainContext)
    }

    public func saveContext(_ context: NSManagedObjectContext) {
      if context != mainContext {
        saveDerivedContext(context)
        return
      }

      context.perform {
        do {
          try context.save()
        } catch let error as NSError {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      }
    }

    public func saveDerivedContext(_ context: NSManagedObjectContext) {
      context.perform {
        do {
          try context.save()
        } catch let error as NSError {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }

        self.saveContext(self.mainContext)
      }
    }
}
