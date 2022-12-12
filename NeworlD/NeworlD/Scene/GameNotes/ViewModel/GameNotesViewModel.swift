//
//  GameNotesViewModel.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 12.12.2022.
//

import Foundation
import CoreData

protocol GameNotesViewModelProtocol {
    var delegate: GameNotesViewModelDelegate? { get set }
 
    func getGameNotesCount() -> Int
}

protocol GameNotesViewModelDelegate: AnyObject {
    func gamesLoaded()
    func gamesFailed(error: Error)
    
    // func preFetch()
    // func postFetch()
}

class GameNotesViewModel: GameNotesViewModelProtocol {
    weak var delegate: GameNotesViewModelDelegate?
    private var notes: [GameNoteEntity]?
    
    func getGameNotesCount() -> Int {
        return notes?.count ?? 0
    }
}
