//
//  GameController.swift
//  GameLibraryCollections
//
//  Created by Lisa Sampson on 9/24/18.
//  Copyright © 2018 Lisa M Sampson. All rights reserved.
//

import Foundation
import CoreData

class GameController {
    
    func createOwnedGame(from gameRep: GameRepresentation) {
    
    }
    
    func createWishlistGame(from gameRep: GameRepresentation) {
        
    }
    
    func delete(game: Game) {
        
    }
    
    func deleteFromServer(game: Game, completion: @escaping (Error?) -> Void = { _ in }) {
        
    }
    
    func put(game: Game, completion: @escaping (Error?) -> Void = { _ in }) {
        
    }
    
    func fetchGameFromStore(identifier: Int16, context: NSManagedObjectContext) -> Game? {
        let fetchRequest: NSFetchRequest<Game> = Game.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "identifier == %@", identifier)
        
        do {
            return try context.fetch(fetchRequest).first
        }
        catch {
            NSLog("Error fetching single game: \(error)")
            return nil
        }
    }
    
    func fetch(completion: @escaping (Error?) -> Void = { _ in }) {
        
    }
    
    func searchForGame(with searchTerm: String, completion: @escaping (Error?) -> Void) {
        
    }
    
    // MARK: - Properties
    
    var games: [Game] = []
    var searchedGames: [GameRepresentation] = []
    
//var request = URLRequest(url: URL(string: "https://api-endpoint.igdb.com/")!)
//request.allHTTPHeaderFields = [
//    "user-key": "cd9dc2bab8859cc9e87a2dbf03d2bbfe",
//    "Accept": "application/json"
//]
    
}
