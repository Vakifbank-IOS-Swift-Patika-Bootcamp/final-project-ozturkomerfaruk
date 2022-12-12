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
    
    func saveNote(title: String, body: String, gameId: Int16) -> GameNoteEntity? {
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
}
