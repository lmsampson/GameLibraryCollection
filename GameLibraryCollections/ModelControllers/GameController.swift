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
        let moc = CoreDataStack.shared.container.newBackgroundContext()
        
        moc.performAndWait {
            _ = Game(gameRep: gameRep, gameIsOwned: true, context: moc)
            
            do {
                try CoreDataStack.shared.save(context: moc)
            }
            catch {
                NSLog("Could not save context.")
                return
            }
        }
    }
    
    func createOwnedGame(from wishlist: Game) {
        
        guard let moc = wishlist.managedObjectContext else { return }
        
        moc.performAndWait {
            wishlist.gameIsOwned = true
            
            do {
                try CoreDataStack.shared.save(context: moc)
            }
            catch {
                NSLog("Could not save context.")
                return
            }
        }
    }
    
    func createWishlistGame(from gameRep: GameRepresentation) {
        let moc = CoreDataStack.shared.container.newBackgroundContext()
        
        moc.performAndWait {
            _ = Game(gameRep: gameRep, gameIsOwned: false, context: moc)
            
            do {
                try CoreDataStack.shared.save(context: moc)
            }
            catch {
                NSLog("Could not save context.")
                return
            }
        }
    }
    
    func delete(game: Game) {
        let moc = CoreDataStack.shared.mainContext
        
        moc.perform {
            do {
            moc.delete(game)
            try CoreDataStack.shared.save(context: moc)
            }
            catch {
                NSLog("Could not save context.")
                return
            }
        }
    }
    
    func searchForGame(with searchTerm: String, completion: @escaping (Error?) -> Void) {
        
        let queryParameters = ["search": searchTerm,
                               "fields": "name,summary,cover.url",
                               "limit": "50"]
        
        var components = URLComponents(url: baseURL.appendingPathComponent("games/"), resolvingAgainstBaseURL: true)
        
        components?.queryItems = queryParameters.map({URLQueryItem(name: $0.key, value: $0.value)})
        
        guard let requestURL = components?.url else {
            completion(NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.allHTTPHeaderFields = [
            "user-key": "cd9dc2bab8859cc9e87a2dbf03d2bbfe",
            "Accept": "application/json"
        ]
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error searching for game with search: \(searchTerm) \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data found.")
                completion(NSError())
                return
            }
            
            do {
                let gameReps = try JSONDecoder().decode([GameRepresentation].self, from: data)
                self.searchedGames = gameReps
                completion(nil)
            }
            catch {
                NSLog("Error decoding JSON: \(error)")
                completion(error)
            }
        }.resume()
    }
    
    // MARK: - Properties
    
    private let baseURL = URL(string: "https://api-endpoint.igdb.com/")!
    
    var searchedGames: [GameRepresentation] = []
    
}
