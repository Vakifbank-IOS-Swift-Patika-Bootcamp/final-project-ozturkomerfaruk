//
//  CoreDataManager.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 11.12.2022.
//

import UIKit
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    private let managedContext: NSManagedObjectContext!
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func getNotes() -> [GameNoteEntity] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GameNoteEntity")
        do {
            let notes = try managedContext.fetch(fetchRequest)
            return notes as! [GameNoteEntity]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    @discardableResult
    func saveNote(title: String, body: String, gameId: Int) -> GameNoteEntity? {
        let entity = NSEntityDescription.entity(forEntityName: "GameNoteEntity", in: managedContext)!
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        
        note.setValue(title, forKey: "title")
        note.setValue(body, forKey: "body")
        note.setValue(gameId, forKey: "gameId")
        
        do {
            try managedContext.save()
            print("Saved to Core Data")
            return note as? GameNoteEntity
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    func deleteNote(model: GameNoteEntity) {
        managedContext.delete(model)
        
        do {
            try managedContext.save()
            print("Deleted to Core Data")
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func updateNote(title: String, body: String, gameId: Int, model: GameNoteEntity) {
            
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GameNoteEntity")
        
        model.title = title
        model.body = body
        model.gameId = Int32(gameId)
        
        do {
            let notes = try managedContext.fetch(fetchRequest)
            for i in notes {
                if i == model {
                    i.setValue(title, forKey: "title")
                    i.setValue(body, forKey: "body")
                    i.setValue(gameId, forKey: "gameId")
                }
            }
            try managedContext.save()
            print("Updated to Core Data")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
