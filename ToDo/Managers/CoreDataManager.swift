//
//  CoreDataManager.swift
//  ToDo
//
//  Created by Vishnu on 08/07/24.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let instance = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "ToDo")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
    }
    
    func createTask(task: Task) {
        let context = persistentContainer.viewContext
        let taskEntity = TaskEntity(context: context)
        taskEntity.update(with: task)
        saveContext()
    }
    
    func fetchAllTasks() -> [Task] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        do {
            let tasks = try context.fetch(fetchRequest)
            return tasks.map { $0.toTask() }
        } catch {
            print("Failed to fetch tasks: \(error)")
            return []
        }
    }
    
    func fetchCompletedTasks() -> [Task] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "progress == %@", NSNumber(value: true))
        do {
            let tasks = try context.fetch(fetchRequest)
            return tasks.map { $0.toTask() }
        } catch {
            print("Failed to fetch tasks: \(error)")
            return []
        }
    }
    
    func updateTask(task: Task) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", task.id)
        
        do {
            let tasks = try context.fetch(fetchRequest)
            if let taskEntity = tasks.first {
                taskEntity.update(with: task)
                saveContext()
            }
        } catch {
            print("Failed to fetch task for update: \(error)")
        }
    }
    
    func deleteTask(task: Task) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", task.id)
        
        do {
            let tasks = try context.fetch(fetchRequest)
            if let taskEntity = tasks.first {
                context.delete(taskEntity)
                saveContext()
            }
        } catch {
            print("Failed to fetch task for deletion: \(error)")
        }
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
                context.rollback()
            }
        }
    }
    
}
